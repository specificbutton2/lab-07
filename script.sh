# Loop through all 4 testcases
for i in {1..4}; do
  test_dir="Testcase$i"
    diff_dir="Testcase${i}Diff"

      # Remove any pre-existing diff directory to ensure clean repeated runs
        rm -rf "$diff_dir"

          # Search for all '.1.txt' files in the Testcase folder
            for file1 in "$test_dir"/*.1.txt; do
                # Skip loop iteration if no matching files are found
                    [ -e "$file1" ] || continue

                        # Derive corresponding .2.txt file and target diff output filename
                            file2="${file1/.1.txt/.2.txt}"
                                base_name="$(basename "$file1" .1.txt)"
                                    diff_file="${base_name}Diff.txt"

                                        # Compare the pair if the matching file exists
                                            if [ -f "$file2" ]; then
                                                  # Run diff and temporarily capture the output
                                                        diff_out=$(diff -u "$file1" "$file2")
                                                              status=$?

                                                                    # Status non-zero means there are differences
                                                                          if [ $status -ne 0 ]; then
                                                                                  # Create output directory only when differences exist
                                                                                          mkdir -p "$diff_dir"
                                                                                                  echo "$diff_out" > "$diff_dir/$diff_file"
                                                                                                        fi
                                                                                                            fi
                                                                                                              done
                                                                                                              done
