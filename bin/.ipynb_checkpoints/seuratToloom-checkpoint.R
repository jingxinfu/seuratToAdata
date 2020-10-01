#!/usr/bin/env Rscript
################################################################################
# Created Date : Tuesday September 29th 2020                                   #
# Author: Jingxin Fu (jingxinfu.tj@gmail.com)                                  #
# ----------                                                                   #
# Last Modified: Tuesday September 29th 2020 4:46:17 pm                        #
# Modified By: Jingxin Fu (jingxinfu.tj@gmail.com)                             #
# ----------                                                                   #
# Copyright (c) Jingxin Fu 2020                                                #
################################################################################
# ----------------------------------------------------------------------
# This script is to convert saurat obj to loom obj 
# ----------------------------------------------------------------------

for(p in c('Seurat','reticulate','loomR','argparse')){
    suppressMessages(require(p,character.only = T))
}

parseInput = function() {
    parser <- ArgumentParser(description='Convert saurat obj to loom obj ')
    inputs <- parser$add_argument_group('Input Option')
    inputs$add_argument('rds',help='Use - for STDIN or path for seurat obj(*.rds file)')
    inputs$add_argument('--RNA',action='store_true',help='Whether is store in the RNA slot')

    outputs <- parser$add_argument_group('Output option')
    outputs$add_argument('-o','--output',required=T,help='Specify path to write the results')
    
    cmds <- parser$add_argument_group('as.loom function')
    args <- parser$parse_args()
    return(args)
}
main = function(){
    args <- parseInput()
    seurat_obj <- readRDS(args$rds)
    if(args$RNA)seurat_obj <-seurat_obj$RNA
    
    seurat_obj <- replaceNA(seurat_obj=seurat_obj)
    
    for(assay in Assays(seurat_obj)){
        if(dim(seurat_obj[[assay]]@meta.features)[2] ==0){
            seurat_obj <- FindVariableFeatures(object = seurat_obj,assay = assay)
        }
        loom_obj <- as.loom(seurat_obj, 
                            filename = paste(args$output,assay,'loom',sep='.'),
                            overwrite=TRUE,
                            verbose = TRUE,
                            assay=assay)
        # close loom files when done
        loom_obj$close_all()
    }

   
}

replaceNA = function(seurat_obj){
    meta <- seurat_obj[[]]
    # Remove all NA columns
    meta <- meta[, !apply(is.na(meta), 2, all)]
    for(v_name in colnames(meta)){
        if(is.factor(meta[,v_name])){
            meta[,v_name] <- as.character(meta[,v_name])
        }
        if(is.character(meta[,v_name])){
            na_entry <- is.na(meta[v_name])
            if(sum(na_entry) >0){
                print(v_name)
                meta[na_entry,v_name] <- '' 
            }
        }
    } 
    seurat_obj@meta.data <-  meta
    return(seurat_obj)
}

main()