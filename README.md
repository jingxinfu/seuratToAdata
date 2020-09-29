# Convert Seurat Obj (rds) to Scanpy obj (adata)

## Usage:
```
conda enve create -f env.yaml
conda activate seuratToAdata

usage: seuratToAdata [-h] -o OUTPUT [--RNA] [--assay ASSAY] rds

positional arguments:
  rds                   Use - for STDIN or path for seurat obj(*.rds file)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Specify path to write the results (default: None)
  --RNA                 Whether is store in the RNA slot (default: False)
  --assay ASSAY         Which assay you want to save? (default: RNA)
```