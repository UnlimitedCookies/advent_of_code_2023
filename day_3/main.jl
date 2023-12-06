lines = readlines("input.txt")

# part 1
global sum = 0
for i ∈ eachindex(lines)
    global end_index = 0
    for j ∈ eachindex(lines[i])
        if isdigit(lines[i][j])
            if j ≤ end_index
                continue
            end
            for k ∈ j:length(lines[i])
                if isdigit(lines[i][k])
                    global end_index = k
                else
                    break
                end
            end

            # check for nearby symbols
            global accept_num = false
            for k ∈ max(i-1, 1):min(i+1, length(lines))
                for l ∈ max(j-1, 1):min(end_index + 1, length(lines[i]))
                    if !isdigit(lines[k][l]) && lines[k][l] ≠ '.'
                        accept_num = true
                    end
                end
            end
            if accept_num
                num = parse(UInt32, lines[i][j:end_index])
                global sum += num
            end
        end
    end
end
println(sum)

#part 2
global sum = 0
for i ∈ eachindex(lines)
    for j ∈ eachindex(lines[i])
        if lines[i][j] == '*'
            global num_count = 0
            global num_product = 1
            for k ∈ max(i-1, 1):min(i+1, length(lines))
                global begin_index = length(lines[i]) + 1
                global end_index = 0
                for l ∈ max(j-1, 1):min(j+1, length(lines[k]))
                    if begin_index ≤ l && l ≤ end_index
                        continue
                    end
                    if isdigit(lines[k][l])
                        global begin_index = l
                        while begin_index > 1 && isdigit(lines[k][begin_index-1])
                            begin_index -= 1
                        end
                        global end_index = l
                        while end_index < length(lines[k]) && isdigit(lines[k][end_index+1])
                            end_index += 1
                        end
                        num = parse(UInt32, lines[k][begin_index:end_index])

                        global num_count += 1
                        global num_product *= num
                    end
                end
            end
            if num_count == 2
                global sum += num_product
            end
        end
    end
end
println(sum)