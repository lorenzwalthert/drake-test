library(drake)
#unlink(".drake", recursive = TRUE)
fun_with_seed <- function(seed, ...) {
  withr::with_seed(seed, {
    rnorm(...)
  })
  
}
plan <- drake_plan(
  a = 1, 
  random = rnorm(1),
  b = ifelse(random > 0, a, a + 1), 
  c = 3, 
  d = fun_with_seed(3, 1),
  e = ifelse(random > 0, a, a + 1)
) 
make(plan, seed = 200)
readd(d)
readd(e)