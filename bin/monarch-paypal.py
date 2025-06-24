"""
This script is used to merge a directory of CSV files output from PayPal transactions export for use in importing to Monarch Money.

Required packages:
pip install pandas 
pip install argparse

Example:
    py monarch-paypal.py ~/Downloads/transaction_dir/ output.csv --start-date 01/05/2024
"""
import os
import sys
import argparse
import pandas as pd
from datetime import datetime

def negate_amount(amount_str):
    if amount_str.startswith('-'):
        # Remove negative sign
        return amount_str[1:]
    else:
        # Add negative sign
        return '-' + amount_str

def merge_and_remap_csvs(input_dir, output_file, start_date=None):
    all_data = []

    # Iterate over CSV files in directory
    for filename in os.listdir(input_dir):
        if filename.endswith(".csv"):
            filepath = os.path.join(input_dir, filename)
            df = pd.read_csv(filepath)

            new_df = pd.DataFrame()
            if start_date:
                # filter out rows before start_date
                df['date'] = pd.to_datetime(df['date'], errors='coerce')
                df = df[df['date'] >= start_date]
            
            new_df['Date'] = df['date']
            new_df['Merchant'] = df['description']
            new_df['Category'] = ''
            new_df['Account'] = 'PayPal Cashback Mastercard'
            new_df['Original Statement'] = df['description']
            new_df['Notes'] = ''
            new_df['Amount'] = df['amount'].apply(negate_amount)
            new_df['Tags'] = ''

            all_data.append(new_df)

    # Concatenate all dataframes
    merged_df = pd.concat(all_data, ignore_index=True)

    # Sort by Date descending
    merged_df['Date'] = pd.to_datetime(merged_df['Date'], errors='coerce')
    merged_df = merged_df.sort_values(by='Date', ascending=False)

    # Save to output CSV
    merged_df.to_csv(output_file, index=False)
    print(f"Merged CSV saved to: {output_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Merge and transform CSV files.")
    parser.add_argument("input_directory", help="Directory containing .csv files")
    parser.add_argument("output_csv", help="Path to save the merged output CSV")
    parser.add_argument("--start-date", help="Only include rows on or after this date (MM/DD/YYYY)", default=None)
    args = parser.parse_args()

    start_date = None
    if args.start_date:
        try:
            start_date = datetime.strptime(args.start_date, "%m/%d/%Y")
        except ValueError:
            print("Error: Start date must be in MM/DD/YYYY format.")
            sys.exit(1)

    merge_and_remap_csvs(args.input_directory, args.output_csv, start_date)
