import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

path = "12\output.csv" # ændre efter behov
df = pd.read_csv(path, sep =',')

# a) What is the distribution of the mean temperatures? Show your results as histograms.
plt.hist(df["mean_temp"], bins=15,edgecolor="darkblue")
plt.xlabel("Mean temperature [degrees celcius]")
plt.ylabel("Frequency")
plt.savefig("12/12a_histogram.png")
plt.show()

# b) What is the average mean temperature of the buildings?
avr_mean_temp = df.mean(numeric_only=True)["mean_temp"]
print(f"b) What is the average mean temperature of the buildings?")
print(f"{avr_mean_temp} degrees \n")

# c) What is the average temperature standard deviation?
std_mean_temp = df.mean(numeric_only=True)["std_temp"]
print(f"c) What is the average temperature standard deviation?")
print(f"{std_mean_temp} degrees \n")

# d) How many buildings had at least 50% of their area above 18ºC?
count_50pct_above_18_deg = df[df["pct_above_18"]>50].count()["pct_above_18"]
print(f"d) How many buildings had at least 50% of their area above 18ºC?")
print(f"{count_50pct_above_18_deg} buildings \n")

# e) How many buildings had at least 50% of their area below 15ºC?
count_50pct_below_15_deg = df[df["pct_below_15"]>50].count()["pct_below_15"]
print(f"e) How many buildings had at least 50% of their area below 15ºC?")
print(f"{count_50pct_below_15_deg} buildings \n")