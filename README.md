# Convert Seurat Obj (rds) to Scanpy obj (adata)

## Usage:
```
conda enve create -f env.yaml
conda activate seuratToAdata

usage: seuratToAdata [-h] -o OUTPUT [--RNA] rds

positional arguments:
  rds                   Use - for STDIN or path for seurat obj(*.rds file)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Specify path to write the results (default: None)
  --RNA                 Whether is store in the RNA slot (default: False)
```

## Issues might arise:
1. UnicodeDecodeError: 'ascii' codec can't decode byte 0xcf in position 1: ordinal not in range(128).
    
    Solved by fixing the locale: https://stackoverflow.com/questions/51026315/how-to-solve-unicodedecodeerror-in-python-3-6/51027262#51027262
