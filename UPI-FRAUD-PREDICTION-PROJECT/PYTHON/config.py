
import pandas as pd
import numpy as np
import random
import os

# Reproducibility
np.random.seed(42)
random.seed(42)

# Project Configuration
NUM_USERS = 10000
NUM_TRANSACTIONS = 200000
NUM_MERCHANTS = 500
NUM_DEVICES = 15000

START_DATE = pd.Timestamp("2026-01-01")
END_DATE = pd.Timestamp("2026-06-30")