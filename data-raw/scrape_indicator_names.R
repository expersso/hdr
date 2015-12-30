library(xml2)
library(tidyr)

url <- "http://hdr.undp.org/en/content/developers-data-api"

page <- read_html(url)
nodes <- xml_find_all(page, "*//h4/following-sibling::ul[1]//li")
indicators <- xml_text(nodes, TRUE)

hdr_indicators <- data.frame(id = indicators[-1], stringsAsFactors = FALSE)
hdr_indicators <- separate(hdr_indicators, id, c("id", "indicator"),
                           sep = "-", extra = "merge")

class(hdr_indicators) <- c("tbl_df", "tbl", "data.frame")

save(hdr_indicators, file = "data/hdr_indicatoirs.rda", compress = "bzip2")
