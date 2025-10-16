module Exercises
    ( firstThenApply
    , powers
    , meaningfulLineCount
    , Shape(Sphere, Box)
    , volume
    , surfaceArea
    , BST(Empty)
    , size
    , contains
    , insert
    , inorder
    ) where

import Data.List (find)

-- 1. firstThenApply with fmap
firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs p f = f <$> find p xs

-- 2. powers - infinite sequence of powers
powers :: (Integral a) => a -> [a]
powers base = iterate (* base) 1

-- 3. meaningfulLineCount
meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount path = do
    content <- readFile path
    return $ length $ filter isMeaningful (lines content)
    where
        isMeaningful :: String -> Bool
        isMeaningful line = case dropWhile (`elem` " \t") line of
            "" -> False
            ('#':_) -> False
            _ -> True

-- 4. Shape types and functions
data Shape
    = Sphere { radius :: Double }
    | Box { width :: Double, len :: Double, depth :: Double }
    deriving (Eq)

instance Show Shape where
    show (Sphere r) = "Sphere " ++ show r
    show (Box w l d) = "Box " ++ show w ++ " " ++ show l ++ " " ++ show d

volume :: Shape -> Double
volume (Sphere r) = (4 / 3) * pi * r ^ 3
volume (Box w l d) = w * l * d

surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * r ^ 2
surfaceArea (Box w l d) = 2 * (w * l + w * d + l * d)

-- 5. Binary Search Tree
data BST a
    = Empty
    | Node a (BST a) (BST a)
    deriving (Eq)

instance (Show a) => Show (BST a) where
    show Empty = "()"
    show (Node value left right) =
        let leftStr = show left
            rightStr = show right
            valueStr = show value
        in case (leftStr, rightStr) of
            ("()", "()") -> "(" ++ valueStr ++ ")"
            ("()", _)    -> "(" ++ valueStr ++ rightStr ++ ")"
            (_, "()")    -> "(" ++ leftStr ++ valueStr ++ ")"
            _            -> "(" ++ leftStr ++ valueStr ++ rightStr ++ ")"

size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right

contains :: (Ord a) => a -> BST a -> Bool
contains _ Empty = False
contains x (Node value left right)
    | x == value = True
    | x < value  = contains x left
    | otherwise  = contains x right

insert :: (Ord a) => a -> BST a -> BST a
insert x Empty = Node x Empty Empty
insert x (Node value left right)
    | x == value = Node value left right
    | x < value  = Node value (insert x left) right
    | otherwise  = Node value left (insert x right)

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node value left right) = inorder left ++ [value] ++ inorder right

