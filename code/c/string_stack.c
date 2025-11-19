#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "string_stack.h"

#define INITIAL_CAPACITY 16

struct _Stack {
    char** elements;
    int capacity;
    int top;
};

static response_code reallocate(stack s, int new_capacity) {
    if (new_capacity > MAX_CAPACITY) {
        return out_of_memory;
    }
    
    char** new_elements = (char**)realloc(s->elements, new_capacity * sizeof(char*));
    if (new_elements == NULL) {
        return out_of_memory;
    }
    
    s->elements = new_elements;
    s->capacity = new_capacity;
    return success;
}

stack_response create() {
    stack_response res;
    stack s = (stack)malloc(sizeof(struct _Stack));
    if (s == NULL) {
        res.code = out_of_memory;
        res.stack = NULL;
        return res;
    }
    
    s->capacity = INITIAL_CAPACITY;
    s->top = -1;
    s->elements = (char**)malloc(INITIAL_CAPACITY * sizeof(char*));
    if (s->elements == NULL) {
        free(s);
        res.code = out_of_memory;
        res.stack = NULL;
        return res;
    }
    
    res.code = success;
    res.stack = s;
    return res;
}

int size(const stack s) {
    return s->top + 1;
}

bool is_empty(const stack s) {
    return s->top == -1;
}

bool is_full(const stack s) {
    return size(s) >= MAX_CAPACITY;
}

response_code push(stack s, char* item) {
    size_t item_len = strlen(item);
    if (item_len >= MAX_ELEMENT_BYTE_SIZE) {
        return stack_element_too_large;
    }
    
    if (is_full(s)) {
        return stack_full;
    }
    
    if (size(s) >= s->capacity) {
        int new_capacity = s->capacity * 2;
        if (new_capacity > MAX_CAPACITY) {
            new_capacity = MAX_CAPACITY;
        }
        response_code code = reallocate(s, new_capacity);
        if (code != success) {
            return code;
        }
    }
    
    s->top++;
    s->elements[s->top] = (char*)malloc((item_len + 1) * sizeof(char));
    if (s->elements[s->top] == NULL) {
        s->top--;
        return out_of_memory;
    }
    strcpy(s->elements[s->top], item);
    
    return success;
}

string_response pop(stack s) {
    string_response res;
    
    if (is_empty(s)) {
        res.code = stack_empty;
        res.string = NULL;
        return res;
    }
    
    char* popped = s->elements[s->top];
    size_t len = strlen(popped);
    res.string = (char*)malloc((len + 1) * sizeof(char));
    if (res.string == NULL) {
        res.code = out_of_memory;
        res.string = NULL;
        return res;
    }
    strcpy(res.string, popped);
    
    free(popped);
    s->top--;
    
    if (s->capacity > INITIAL_CAPACITY && size(s) < s->capacity / 4) {
        int new_capacity = s->capacity / 2;
        if (new_capacity < INITIAL_CAPACITY) {
            new_capacity = INITIAL_CAPACITY;
        }
        reallocate(s, new_capacity);
    }
    
    res.code = success;
    return res;
}

void destroy(stack* s) {
    if (s == NULL || *s == NULL) {
        return;
    }
    
    for (int i = 0; i <= (*s)->top; i++) {
        free((*s)->elements[i]);
    }
    
    free((*s)->elements);
    
    free(*s);
    *s = NULL;
}
