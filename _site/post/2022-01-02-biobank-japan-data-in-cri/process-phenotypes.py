import os
import pandas as pd
import argparse

def getPhenoList(dir):
    phenoList = []
    for root, dirs, files in os.walk(dir):
        for name in files:
            if name.endswith(".pheno"):
                phenoList.append(os.path.join(root, name))
    
    return sorted(phenoList)

def run(args):
    dataDir = args.BBJ_folder
    phenoDict = args.phenotype_mapping
    output = args.output

    phenoList = getPhenoList(dataDir)
    phenoMapping = pd.read_table(phenoDict)
    df = pd.read_table(phenoList[0], sep = " ", header=None)
    df.columns = ["Individual", "BMI"]
    for i in range(1, len(phenoList)):
        pheno = pd.read_table(phenoList[i], sep = "\t", header=None)
        phenoName = phenoMapping["Trait"][i]
        pheno.columns = ["Individual", phenoName]
        df = df.merge(pheno, on="Individual", how="outer")
    df.to_csv(output, index=False)




if __name__ == "__main__":
    parser = argparse.ArgumentParser("Combine all BBJ phenotype files into one")
    parser.add_argument("--BBJ_folder", help="path of the directory containing all decrypted BBJ data")
    parser.add_argument("--phenotype_mapping", help="path of BBJ-phenotype-list.txt containing phenotypes and their folder names")
    parser.add_argument("--output", help="path output csv file")
    args = parser.parse_args()
    run(args)