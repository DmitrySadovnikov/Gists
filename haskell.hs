ghci - haskell iterpreter

:load Test - загружаем млдуль тест в консоле (модуль это файл)

module Test where
main = putStrLn "Hello, world!"

:reload

max 5 42
(max 5) 42
~> 42

{- определяем функцию -}
let funcName // определение функции в интерпретаторе

sumSquares x y = x ^ 2 + y ^ 2
rock'n'roll = 42 // это тоже функция
lenVec3 x y z = sqrt (x ^ 2 + y ^ 2 + z ^ 2) // длина трехмерного вектора

let fourtyTwo = 39 + 3 // константная функция (потомучто не имеет на входе параметров)
let f x = if x > 0 then 1 else (-1) // на выходе из if должны быть значения одного типа
f (-5) // = -1
sign x = if x > 0 then 1 else if x == 0 then 0 else -1

// идентичные функции
max5 x = max 5 x
max5'  = max 5

// частичное применеие
let discount limit proc sum = if sum >= limit then sum * (100 - proc) / 100 else sum
let standartDiscount = discount 1000 5 //limit = 1000, proc = 5, sum = передаваемый параметр
translate languageTo languageFrom text // лучший порядок переменных для функции translateFromSpanishToRussian