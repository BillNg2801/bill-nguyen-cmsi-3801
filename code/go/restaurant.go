package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

func do(seconds int, action ...any) {
	log.Println(action...)
	randomMillis := 500*seconds + rand.Intn(500*seconds)
	time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

type Order struct {
	id         uint64
	customer   string
	reply      chan *Order
	preparedBy string
}

var nextOrderID atomic.Uint64

func newOrder(customer string) *Order {
	return &Order{
		id:       nextOrderID.Add(1),
		customer: customer,
		reply:    make(chan *Order, 1),
	}
}

var waiter chan *Order = make(chan *Order, 3)

func cook(name string) {
	log.Println(name, "starting work")
	for order := range waiter {
		do(10, name, "cooking order", order.id, "for", order.customer)
		order.preparedBy = name
		order.reply <- order
	}
}

func customer(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	
	for mealsEaten := 0; mealsEaten < 5; {
		order := newOrder(name)
		log.Println(name, "placed order", order.id)

		select {
		case waiter <- order:
			meal := <-order.reply
			do(2, name, "eating cooked order", meal.id, "prepared by", meal.preparedBy)
			mealsEaten++
		case <-time.After(7 * time.Second):
			do(5, name, "waiting too long, abandoning order", order.id)
		}
	}
	log.Println(name, "going home")
}

func main() {
	customers := []string{
		"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai",
	}

	go cook("Remy")
	go cook("Colette")
	go cook("Linguini")

	var wg sync.WaitGroup
	for _, customerName := range customers {
		wg.Add(1)
		go customer(customerName, &wg)
	}

	wg.Wait()

	log.Println("Restaurant closing")
	close(waiter)
}
