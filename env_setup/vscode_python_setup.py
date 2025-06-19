#!/usr/bin/env python
# coding: utf-8

# # Auto install python libraries for Data Science

# 

# In[ ]:


# -*- coding: utf-8 -*-

import subprocess
import sys

def install_libs(packages):
    for package in packages:
        try:
            __import__(package["import_name"])
            print(f"✅ {package['name']} already installed")
        except ImportError:
            print(f"⬇️ Installing {package['name']}...")

            # ✅ Handle both string and list pip_name
            pip_args = package["pip_name"]
            if isinstance(pip_args, str):
                pip_args = [pip_args]

            try:
                subprocess.check_call([sys.executable, "-m", "pip", "install", *pip_args])
                print(f"✅ {package['name']} installed")
            except subprocess.CalledProcessError as e:
                print(f"❌ Failed to install {package['name']}: {e}")



# In[ ]:


def upgrade_pip():
    """
    Upgrade pip to the latest version using subprocess.
    """
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "pip"])
        print("✅ pip upgraded successfully.")
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to upgrade pip: {e}")


upgrade_pip() #upgrade pip first


# # Mac specific pre-setup by installing require brew packages.

# In[ ]:


import shutil
import platform

def is_brew_available():
    return shutil.which("brew") is not None

def is_package_installed(package):
    result = subprocess.run(["brew", "list", "--formula", package], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    return result.returncode == 0

def brew_install(packages):
    if not is_brew_available():
        print("❌ Homebrew is not available in PATH.")
        return

    for package in packages:
        if is_package_installed(package):
            print(f"✅ {package} is already installed.")
        else:
            print(f"⬇️ Installing {package}...")
            try:
                subprocess.check_call(["brew", "install", package])
                print(f"✅ {package} installed successfully.\n")
            except subprocess.CalledProcessError as e:
                print(f"❌ Failed to install {package}: {e}\n")

# brew packages to install
libs = ["unixodbc", # ODBC driver for Snowflake
        "snowflake", # Snowflake CLI
        "libomp", # OpenMP support for XGBoost & LightGBM
        'cmake', # CMake build system
        "llvm", # Modern compiler toolchain used by some ML libraries
        'openssl@3', # OpenSSL 3.x for compatibility
        ]


# Brew install if on macOS
if platform.system() == 'Darwin':  # macOS returns 'Darwin'
    brew_install(libs)
else:
    print("Not on macOS, skipping brew install")


# # Data Science Libraries
# ## 1. Data Wraggling Libs

# In[ ]:


dw = [
    # ✅ Data Wrangling
    {"name": "Pandas", "pip_name": "pandas", "import_name": "pandas"},
    {"name": "Polars", "pip_name": "polars", "import_name": "polars"},
    {"name": "Dask", "pip_name": "dask[dataframe]", "import_name": "dask"},
    {"name": "PyArrow", "pip_name": "pyarrow", "import_name": "pyarrow"},
    {"name": "PyTables", "pip_name": "tables", "import_name": "tables"},
    {"name": "Feather", "pip_name": "pyarrow", "import_name": "pyarrow.feather"},
    {"name": "Parquet", "pip_name": "pyarrow", "import_name": "pyarrow.parquet"},
    {"name": "HDF5", "pip_name": "tables", "import_name": "tables"},
    {"name": "CSV", "pip_name": "pandas", "import_name": "pandas"},
    {"name": "JSON", "pip_name": "pandas", "import_name": "pandas"},
    {"name": "Excel", "pip_name": "openpyxl", "import_name": "openpyxl"},
    {"name": "HDF5", "pip_name": "tables", "import_name": "tables"},
]

install_libs(dw)


# ## 2. Data Connectors

# In[ ]:


dc = [
    # 🔌 Data Connections – Databases
    {"name": "SQLAlchemy", "pip_name": "sqlalchemy", "import_name": "sqlalchemy"},
    {"name": "PyODBC", "pip_name": "pyodbc", "import_name": "pyodbc"},
    {"name": "psycopg2 (PostgreSQL)", "pip_name": "psycopg2-binary", "import_name": "psycopg2"},
    {"name": "MySQL Connector", "pip_name": "mysql-connector-python", "import_name": "mysql.connector"},
    {"name": "MongoDB", "pip_name": "pymongo", "import_name": "pymongo"},
    {"name": "SQLite", "pip_name": "sqlite3", "import_name": "sqlite3"},

    # 🔌 Data Connections – Cloud
    {"name": "Snowflake Connector", "pip_name": "snowflake-connector-python", "import_name": "snowflake.connector"},
    {"name": "Google BigQuery", "pip_name": "google-cloud-bigquery", "import_name": "google.cloud.bigquery"},
    {"name": "AWS SDK (boto3)", "pip_name": "boto3", "import_name": "boto3"},
    {"name": "Azure SDK", "pip_name": "azure-storage-blob", "import_name": "azure.storage.blob"},
    {"name": "Databricks SQL Connector", "pip_name": "databricks-sql-connector", "import_name": "databricks.sql"},
    {"name": "Apache Kafka", "pip_name": "kafka-python", "import_name": "kafka"},

    # 📂 Microsoft SharePoint (via Office365 REST API)
    {"name": "Office365-REST-Python-Client", "pip_name": "Office365-REST-Python-Client", "import_name": "office365.sharepoint.client_context"},

    # 📊 Tableau / Power BI Integration
    {"name": "Tableau Hyper API", "pip_name": "tableauhyperapi", "import_name": "tableauhyperapi"},
    {"name": "Power BI REST Client", "pip_name": "powerbiclient", "import_name": "powerbiclient"},

    # 🌐 API Libraries
    {"name": "Requests", "pip_name": "requests", "import_name": "requests"},
    {"name": "HTTPX", "pip_name": "httpx", "import_name": "httpx"},
    {"name": "FastAPI", "pip_name": "fastapi", "import_name": "fastapi"},
    {"name": "Uvicorn (for FastAPI)", "pip_name": "uvicorn", "import_name": "uvicorn"},
    {"name": "Flask", "pip_name": "flask", "import_name": "flask"},
    {"name": "Django", "pip_name": "django", "import_name": "django"},
    {"name": "Tornado", "pip_name": "tornado", "import_name": "tornado"},
]

install_libs(dc)


# ## 3. Stat and Visualization Libs

# In[ ]:


sv = [
    # 🔍 Search & Text Processing
    {"name": "Whoosh", "pip_name": "whoosh", "import_name": "whoosh"},
    {"name": "NLTK", "pip_name": "nltk", "import_name": "nltk"},
    {"name": "spaCy", "pip_name": "spacy", "import_name": "spacy"},
    {"name": "TextBlob", "pip_name": "textblob", "import_name": "textblob"},
    {"name": "Gensim", "pip_name": "gensim", "import_name": "gensim"},

    # 🧭 Data exploration and profiling
    {"name": "DataExplorer", "pip_name": "dataexplorer", "import_name": "dataexplorer"},
    {"name": "DataProfiler", "pip_name": "dataprofiler", "import_name": "dataprofiler"},
    {"name": "Autoviz", "pip_name": "autovizwidget", "import_name": "autovizwidget"},
    {"name": "AutoViz", "pip_name": "autoviz", "import_name": "autoviz"},
    {"name": "Pandas Profiling", "pip_name": "pandas-profiling", "import_name": "pandas_profiling"},
    {"name": "YData Profiling", "pip_name": "ydata-profiling", "import_name": "ydata_profiling"},
    {"name": "Sweetviz", "pip_name": "sweetviz", "import_name": "sweetviz"},
    {"name": "D-Tale", "pip_name": "d-tale", "import_name": "dtale"},

    # 📊 Statistics & Math
    {"name": "NumPy", "pip_name": "numpy", "import_name": "numpy"},
    {"name": "SciPy", "pip_name": "scipy", "import_name": "scipy"},
    {"name": "Statsmodels", "pip_name": "statsmodels", "import_name": "statsmodels"},

    # 📈 Visualization
    {"name": "Matplotlib", "pip_name": "matplotlib", "import_name": "matplotlib"},
    {"name": "Seaborn", "pip_name": "seaborn", "import_name": "seaborn"},
    {"name": "Plotly", "pip_name": "plotly", "import_name": "plotly"},
    {"name": "Altair", "pip_name": "altair", "import_name": "altair"},
    {"name": "Bokeh", "pip_name": "bokeh", "import_name": "bokeh"},
    {"name": "Geopandas", "pip_name": "geopandas", "import_name": "geopandas"},
]

install_libs(sv)


# ## 4. ML and Other Libs

# In[ ]:


# Define required packages
import os
os.environ["DYLD_LIBRARY_PATH"] = "/opt/homebrew/opt/libomp/lib"

ml = [
    # 🤖 Machine Learning
    {"name": "Scikit-learn", "pip_name": "scikit-learn", "import_name": "sklearn"},
    {"name": "CatBoost", "pip_name": "catboost", "import_name": "catboost"},
    {"name": "Category Encoders", "pip_name": "category_encoders", "import_name": "category_encoders"},
    {"name": "PyTorch", "pip_name": ["torch", "torchvision", "torchaudio"], "import_name": "torch"},
    {"name": "Keras", "pip_name": "keras", "import_name": "keras"},
    {"name": "Hugging Face Transformers", "pip_name": "transformers", "import_name": "transformers"},
    {"name": "Fastai", "pip_name": "fastai", "import_name": "fastai"},
    {"name": "TPOT", "pip_name": "tpot", "import_name": "tpot"},
    {"name": "MLflow", "pip_name": "mlflow", "import_name": "mlflow"},

    # 🧪 Notebook Environment
    {"name": "JupyterLab", "pip_name": "jupyterlab", "import_name": "jupyterlab"},
    {"name": "Notebook", "pip_name": "notebook", "import_name": "notebook"},
    {"name": "Voila", "pip_name": "voila", "import_name": "voila"},

]

install_libs(ml)


# In[ ]:


ml2 = [
    # 🤖 Machine Learning 2 - separating out these bc they tend to encounter trouble when installing
    {"name": "XGBoost", "pip_name": "xgboost", "import_name": "xgboost"},
    {"name": "LightGBM", "pip_name": "lightgbm", "import_name": "lightgbm"},
    # {"name": "TensorFlow", "pip_name": "tensorflow", "import_name": "tensorflow"},
    ]

install_libs(ml2)


# In[ ]:


# !pip uninstall xgboost -y


# # Pip Upgrade all Lib (optional)

# In[ ]:


import pkg_resources
def upgrade_all_packages():
    """
    Upgrade all installed pip packages to their latest version.
    """
    print("🔍 Collecting installed packages...")
    packages = [dist.project_name for dist in pkg_resources.working_set]

    print("🚀 Upgrading packages...")
    for package in packages:
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", package])
            print(f"✅ Upgraded: {package}")
        except subprocess.CalledProcessError as e:
            print(f"❌ Failed to upgrade {package}: {e}")

# upgrade_all_packages()

