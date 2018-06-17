package main

import (
    "fmt"
    "io"
    "io/ioutil"
    "os"
    "strings"
    "strconv"
)

const MAX_LIST = 256

var out io.Writer = ioutil.Discard
func init() {
    switch os.Getenv("ADVENT_DEBUG") {
    case "1":
        out = os.Stdout
    default:
        out = ioutil.Discard
    }
}

type Hash struct {
    list []int
    skipsize int
    position int
}

func NewHash(list []int) Hash {
    return Hash{list, 0, 0}
}

func (hash *Hash) String() string {
    return fmt.Sprintf("%#v", hash)
}

func (hash *Hash) swap(i, j int) {
    n := len(hash.list)
    fmt.Fprintf(out, "Swaping %d with %d\n", i % n, j % n)
    if i != j {
        hash.list[i % n], hash.list[j % n] = hash.list[j % n], hash.list[i % n]
    }
}

func (hash *Hash) reverse(n int) error {
    i := hash.position
    j := hash.position + n - 1
    if len(hash.list) < n {
        return fmt.Errorf("n is too big")
    }
    for i < j {
        hash.swap(i, j)
        i++
        j--
    }
    return nil
}

func (hash *Hash) iterate(length int) error {
    err := hash.reverse(length); if err != nil {
        return err
    }
    hash.position = (hash.position + length + hash.skipsize) % len(hash.list)
    hash.skipsize = hash.skipsize + 1
    return nil
}

func (hash *Hash) Compute(lengths []int) (int, error) {
    for _, l := range lengths {
        fmt.Fprintf(out, "Iterating %d\n", l)
        err := hash.iterate(l); if err != nil {
            return 0, err
        }
        fmt.Fprintf(out, "   - %s\n", hash)
    }

    return (hash.list[0] * hash.list[1]), nil
}

func makeXS() []int {
    xs := make([]int, MAX_LIST)
    for i := range xs {
        xs[i] = i
    }
    return xs
}

func readInput() ([]int, error) {
    inputBytes, err := ioutil.ReadAll(os.Stdin)
    if err != nil {
        fmt.Printf("Error: %s\n", err.Error())
    }
    inputString := strings.Split(strings.TrimSuffix(string(inputBytes), "\n"), ",")
    length := make([]int, len(inputString))
    for i, v := range inputString {
        length[i], err = strconv.Atoi(v); if err != nil {
            return nil, fmt.Errorf("Invalid input: %s", v)
        }
    }
    return length, nil
}

func main() {
    lengths, err := readInput()
    if err != nil {
        fmt.Printf("Error: %s\n", err.Error())
    }
    hash := NewHash(makeXS())
    fmt.Fprintf(out, "Initial hash: %#v\n", hash)
    result, err := hash.Compute(lengths)
    if err != nil {
        fmt.Printf("Error: %s\n", err.Error())
    } else {
        fmt.Printf("result: %#v\n", result)
    }
}
