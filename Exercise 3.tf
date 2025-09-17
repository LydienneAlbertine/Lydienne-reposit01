variable "raw_scores" {
 type    = list(string)
 default = ["alice:90", "bob:75", "carol:85"]
}
locals {
 score_pairs = [
 for s in var.raw_scores : {
 name  = split(":", s)[0]
 score = tonumber(split(":", s)[1])
 }
 ]
 scores_map   = { for p in local.score_pairs : p.name => p.score }
 average      = length(local.score_pairs) = 0 ? 0 :
}
 sum=([for p in local.score_pairs : p.score]) / length(local.score_pairs)
}
output "scores_map" { value = local.scores_map }
output "avg_score"  { value = local.average    }
}
