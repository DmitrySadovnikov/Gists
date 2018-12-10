int8  (-128 to 127)
int16 (-32768 to 32767)
int32 (-2147483648 to 2147483647)
int64 (-9223372036854775808 to 9223372036854775807)

//// Pointer
var message string = "Hello"
var greeting *string = &message
*greeting = "Hi"
fmt.Println(message, *greeting) // => Hi Hi
////

//// iota
const (
    A = iota
    B = iota
    C = iota
)

fmt.Println(A, B, C) // => 0, 1, 2

const (
  A = iota
  B
  C
)

fmt.Println(A, B, C) // => 0, 1, 2
////


//// slice
func CreateMessage(name string, greeting ...string) (message string, alternate string) {
    message = greeting[1] + " " + name
    alternate = "HEY! " + name
    return
}
////

//// closures
type Printer func(string) ()

func CreatePrintFunction(custom string) Printer {
    return func(s string) {
        fmt.Println(s + custom)
    }
}

func Greet(s Salutation, do Printer) {
    msg, alter := CreateMessage(s.name, s.greeting, "yo")
    do(msg)
    do(alter)
}

func main() {
    var s = Salutation("Bob", "Hello")
    Greet(s, CreatePrintFunction("!!!"))
}
////

//// if
isFormal := true

if prefix := "Mr "; isFormal {
  do(prefix + msg)
}

// ok idiom
func (s *stack) Pop() (int, bool) {
    if ... {
        return 0, false
    }

    return v, true
}

s := &stack{}

if v, ok := s.Pop(); ok {
}
////

//// switch case
func TypeSwitchTest(x inerface{}) {
    switch x.(type) {
        case int: fmt.Println("int")
        case string: fmt.Println("string")
        case Salutation: fmt.Println("salutation")
        default: fmt.Println("unknown")
    }
}
////

//// loop
i := 0

for {
    if i >= times {
        break
    }

    if i % 2 == 0 {
        i++
        continue
    }

    i++
}
//
for i := 0; i < 10; i++ {

}
////

//// Ranges
type Salutation struct {
    Name string
    Greeting string
}

var slice = greeting.Salutation("Bob", "Hello")
slice := []greeting.Salutation {
        {"Bob", "Hello"}
        {"Joe", "Hi"}
        {"Mary", "What's up?"}
}

slice[1:2] // {"Joe", "Hi"}
slice = append(slice, slice...) // duplicate all slice
////

//// Map
var prefixMap map[string]string
prefixMap = make(map[string]string)

prefixMap["Bob"] = "Mr "
prefixMap["Joe"] = "Dr "
prefixMap["Amy"] = "Dr "
prefixMap["Mary"] = "Mrs "
//
prefixMap := map[string]string {
    "Bob" : "Mr ",
    "Joe" : "Dr ",
    "Amy" : "Dr ",
    "Mary" : "Mrs "
}
prefixMap["Joe"] = "Jr "
delete(prefixMap, "Mary")
////

//// Type methods
type Salutation struct {
  Name string
  Greeting string
}

type Salutations []Salutation

func (salutations Salutations) Greet(do Printer, isFormal bool, times int) {
  for _, s := range salutations {
    msg, alter := CreateMessage(s.name, s.greeting, "yo")
  }
}

func (salutation *Salutation) Rename(newName string) {
    salutation.Name = newName
}

func main() {
    s := Salutation { "Bob", "Hello" }
    s.Rename("Joe")
}
////

//// Interface
type Renamable interface {
    Rename(newName string)
}

func RenameToFrog(r greeting.Renamable) {
    r.Rename("Frog")
}

func main() {
  s := Salutation { "Bob", "Hello" }
  RenameToFrog(&s)
}
////

package main

import (
    "fmt"
    "os"
    "time"
    "errors"
    "sync"
)

func main1() {
    // _args := os.Args // assign var with autotype

    var args []string = os.Args
    var str string = "Lol"

    fmt.Println(str)

    if len(args) > 1 {
        fmt.Println(args)
    } else {
        fmt.Println("default message")
    }
}

// gvm install go1.9.2 --binary
// gvm use go1.9.2 --default

// go run src/hello/main.go
// go build src/hello/main.go
// ./main					                   // execute code
// gofmt -w src/hello/main.go                  // format code
// goimports -w src/hello/main.go              // add import
// go run src/hello/main.go "custom message"

//////////////////////

func main2() {
    hourOfDay := time.Now().Hour()
    greeting, err := getGreeting(hourOfDay)

    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }

    fmt.Println(greeting)
}

func getGreeting(hour int) (string, error) {
    var message string

    if hour < 7 {
        err := errors.New("too early for greetings")
        return message, err
    }

    if hour < 12 {
        message = "Good Morning"
    } else if hour < 18 {
        message = "Good Afternoon"
    } else {
        message = "Good Evening"
    }

    return message, nil
}

func defaultValues() {
    var str string
    fmt.Println(str) // ""

    var digit int
    fmt.Println(digit) // 0

    var boolean bool
    fmt.Println(boolean) // false

    var flo float32
    fmt.Println(flo) // 0.0

    var bit byte
    fmt.Println(bit) // 0
}

//////////////////////

// loops
func main3() {
    for i := 0; i < 5; i++ {
        fmt.Println(i)
    }

    i := 0
    isLessThenFive := true

    for isLessThenFive {
        if i >= 5 {
            isLessThenFive = false
        }

        if i >= 5 {
            break
        }

        fmt.Println(i)
        i++
    }

    for {
        if 1+1 == 2 {
            break
        }
    }
}

// arrays

func main4() {
    var langs [3]string

    langs[0] = "Go"
    langs[1] = "Ruby"
    langs[2] = "JS"

    fmt.Println(langs)
}

func main5() {
    var langs []string // slice array

    langs = append(langs, "Go")
    langs = append(langs, "Ruby")
    langs = append(langs, "JS")
    addToBlockedList(langs)
}

func addToBlockedList(ips [4]string){}

func main6() {
    langs := getLangs()

    for i := range langs {
        fmt.Println(langs[i])
    }
    // or
    for _, element := range langs {
        fmt.Println(element)
    }
}

func getLangs() []string  {
    langs := []string{"Go", "Ruby", "JS"}
    return langs
}

// struct

type gopher struct {
    name string
    age  int
    isAdult bool
}

func (g gopher) jump() string {
    if g.age < 65 {
        return g.name + " can jump HIGH"
    }

    return g.name + " can still jump"
}

func  main()  {
    gopher1 := &gopher{name: "Gopher 1", age: 66}
    gopher2 := &gopher{name: "Gopher 2", age: 20}

    validateAge(gopher1)

    fmt.Println(gopher1.jump()) // Gopher 1 can still jump
    fmt.Println(gopher2.jump()) // Gopher 2 can jump HIGH
    fmt.Println(gopher1)        // &{Gopher 1 66 true}
    fmt.Println(gopher2)        // {Gopher 2 25 false} false is default value

}

func validateAge(g *gopher) {
    g.isAdult = g.age >= 12
}

func getList() []*gopher {
    gopher1 := &gopher{name: "Gopher 1", age: 66}
    gopher2 := &gopher{name: "Gopher 2", age: 20}

    list := []*gopher{gopher1, gopher2}
    return list
}
// reference

func main7() {
    language := "Go"
    favoriteLang := &language

    language = "Ruby"
    fmt.Println(language)       // Ruby
    fmt.Println(favoriteLang)   // 0xc42000e1d0 Ruby
    fmt.Println(*favoriteLang)  // Ruby
}

// interface

type jumper interface {
    jump() string // Все struct имеющие метод jump() являются jumper
}

type horse struct {
    name string
    weight int
}

type gopher struct {
    name string
    age  int
    isAdult bool
}

func (g gopher) jump() string {
    if g.age < 65 {
        return g.name + " can jump HIGH"
    }

    return g.name + " can still jump"
}

func (g horse) jump() string {
    if g.weight < 2000 {
        return g.name + " can jump HIGH"
    }

    return g.name + " can still jump"
}

func getList() []jumper {
    gopher1 := &gopher{name: "Gopher 1", age: 66}
    gopher2 := &gopher{name: "Gopher 2", age: 20}
    horse1  := &horse{name: "Horse 1", weight: 1233}

    list := []jumper{gopher1, gopher2, horse1}
    return list
}

func main() {
    for _, element := range getList() {
        fmt.Println(element)
    }
}

// reader / writer

type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

// packages
package main

import (
"fmt"
"hello/model"
)

func main() {
    list := model.GetList() // First letter should be BIG
    fmt.Print(list)
}

package model

import (
"fmt"
"hello/model"
)

func GetList() {
    ...
}

// concurrency

func main() {
    names := []string{"A", "B", "C"}
    var wg sync.WaitGroup
    wg.Add(len(names))

    for _, name := range names {
        go printName(name, &wg)
    }

    wg.Wait()
}

func printName(name string, wg *sync.WaitGroup) {
    fmt.Println(name)
    wg.Done()
}

// time GOMAXPROCS=1 go run main.go
