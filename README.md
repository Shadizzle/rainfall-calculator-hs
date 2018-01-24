# Rainfall Calculator

Implement a Rainfall Calculator using functional programming constructs (map, filter, fold, etc).

Create a program that reads a list of numbers representing daily rainfall.  The list contains integers where -999 terminates the data to be processed.
Return the average of the non-negative integers up to, and not including, the first -999.

For example:
```
[1,1,1,1,1,1,1,1,1,-999] -> 1
[1,2,3,4,5,-999] -> 3
[1,-1,-999] -> 1
[-999]  -> No result (Nothing)
[1,-1,9,0,10,99,-999,0,1,...] -> 23.8
```

## Requirements

You will need to install [GHC](https://www.haskell.org/ghc) to compile from source, but comes with a `rainfall-arch` file precompiled on Arch Linux.

## Usage

To compile source, run the following from the project root (you made need to add a `-dynamic` flag on a system where GHC is packaged with dynamic linking):
```
ghc -o rainfall rainfall.hs
```

Run all of the examples provided in the task description like so:
```
./rainfall "[1,1,1,1,1,1,1,1,1,(-999)]" "[1,2,3,4,5,(-999)]" "[1,(-1),(-999)]" "[(-999)]" "[1,(-1),9,0,10,99,(-999),0,1]"
```

Which should print the following:
```
[1,1,1,1,1,1,1,1,1,(-999)] -> 1.0
[1,2,3,4,5,(-999)] -> 3.0
[1,-1,(-999)] -> 1.0
[(-999)] -> No Result
[1,(-1),9,0,10,99,(-999),0,1] -> 23.8
```
