# How to Use This Code:

# 1. First, create a square, invertible matrix.
#    For example, a 3x3 matrix with random numbers.
random_matrix <- matrix(rnorm(9), nrow = 3)

# 2. Next, use makeCacheMatrix() to create a special object
#    that encapsulates the matrix and its cache.
cached_object <- makeCacheMatrix(random_matrix)

# 3. Finally, pass this special object to cacheSolve().
#    The first time, it will compute the inverse.
#    Subsequent times, it will retrieve the result from the cache.
cacheSolve(cached_object)


makeCacheMatrix <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setcache <- function(solve) m <<- solve
    getcache <- function() m
    list(set = set, get = get,
         setcache = setcache,
         getcache = getcache)
}
cacheSolve <- function(x, ...) {
    m <- x$getcache()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setcache(m)
    m
}