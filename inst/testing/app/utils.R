num_super_script <- function(x) {
      num <- as.numeric(x)
      if (num == 1) {
        super_script <- "st"
      } else if (num == 2) {
        super_script <- "nd"
      } else if (num == 3) {
        super_script <- "rd"
      } else {
        super_script <- "th"
      }
    return(super_script)
}