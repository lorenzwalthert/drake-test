library(drake)
#unlink(".drake", recursive = TRUE)
fun_with_seed <- function(seed, ...) {
  withr::with_seed(seed, {
    rnorm(...)
  })
  
}

just_sleeping <- function(a) {
  Sys.sleep(4)
}

plan <- drake_plan(
  a = 1, 
  random = rnorm(1),
  b = ifelse(random > 0, a, a + 1), 
  c = 3, 
  d = fun_with_seed(3, 1),
  e = ifelse(random > 0, a, a + 1), 
  x_2 = just_sleeping(2),
  x_5 = just_sleeping(5),
  y = just_sleeping(x_5)
) 
make(plan, seed = 200)
readd(d)
readd(e)