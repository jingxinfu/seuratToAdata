import setuptools
from seuratToAdata import __version__

with open("README.md", "r") as fh:
    long_description = fh.read()
NAME='seuratToAdata'
try:
    f = open("requirements.txt", "rb")
    REQUIRES = [i.strip() for i in f.read().decode("utf-8").split("\n")]
    f.close()
except:
    print("'requirements.txt' not found!")
    REQUIRES = []

setuptools.setup(
    name=NAME,
    version=__version__,
    author="Jingxin Fu",
    author_email="jingxinfu.tj@gmail.com",
    description="Convert seurat obj to Adata",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://jingxinfu.github.io/"+NAME,
    packages=setuptools.find_packages(),
    scripts=['bin/'+NAME],
    include_package_data=True,
    install_requires=REQUIRES,
    python_requires='>=3.5',
    keywords= ['Bioinformatics','Genomics','Computational Biologist'],
    classifiers=[
        "Programming Language :: Python",
        "License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)",
        "Operating System :: Unix",
        "Operating System :: MacOS",
    ]
)
