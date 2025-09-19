-- first_then_apply: finds first element satisfying predicate and applies function
function first_then_apply(sequence, predicate, func)
    for i = 1, #sequence do
        if predicate(sequence[i]) then
            return func(sequence[i])
        end
    end
    return nil
end

-- powers_generator: coroutine that yields successive powers of base up to limit
function powers_generator(base, limit)
    return coroutine.create(function()
        local power = 1
        while power <= limit do
            coroutine.yield(power)
            power = power * base
        end
    end)
end

-- say: chainable function that accumulates words
function say(word)
    local words = {}
    
    local function add_word(w)
        if w ~= nil then
            table.insert(words, w)
            return add_word
        else
            return table.concat(words, " ")
        end
    end
    
    if word ~= nil then
        table.insert(words, word)
        return add_word
    else
        return ""
    end
end

-- meaningful_line_count: counts non-empty, non-whitespace, non-comment lines
function meaningful_line_count(filename)
    local file = io.open(filename, "r")
    if not file then
        error("No such file")
    end
    
    local count = 0
    for line in file:lines() do
        -- Check if line is not empty and not just whitespace
        if line:match("%S") then
            -- Check if first non-whitespace character is not #
            local first_non_whitespace = line:match("^%s*(.)")
            if first_non_whitespace ~= "#" then
                count = count + 1
            end
        end
    end
    
    file:close()
    return count
end

-- Quaternion datatype following the exact course pattern
Quaternion = (function (class)
    local meta = {
        __add = function(self, other)
            return class.new(
                self.a + other.a,
                self.b + other.b,
                self.c + other.c,
                self.d + other.d
            )
        end,
        __mul = function(self, other)
            return class.new(
                self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d,
                self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c,
                self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b,
                self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
            )
        end,
        __eq = function(self, other)
            return self.a == other.a and self.b == other.b and 
                   self.c == other.c and self.d == other.d
        end,
        __tostring = function(self)
            local parts = {}
            
            -- Handle real part
            if self.a ~= 0 then
                table.insert(parts, tostring(self.a))
            end
            
            -- Handle i component
            if self.b ~= 0 then
                local coeff = self.b
                if coeff == 1 then
                    table.insert(parts, "i")
                elseif coeff == -1 then
                    table.insert(parts, "-i")
                else
                    table.insert(parts, tostring(coeff) .. "i")
                end
            end
            
            -- Handle j component
            if self.c ~= 0 then
                local coeff = self.c
                if coeff == 1 then
                    table.insert(parts, "j")
                elseif coeff == -1 then
                    table.insert(parts, "-j")
                else
                    local sign = coeff > 0 and "+" or ""
                    table.insert(parts, sign .. tostring(coeff) .. "j")
                end
            end
            
            -- Handle k component
            if self.d ~= 0 then
                local coeff = self.d
                if coeff == 1 then
                    table.insert(parts, "k")
                elseif coeff == -1 then
                    table.insert(parts, "-k")
                else
                    local sign = coeff > 0 and "+" or ""
                    table.insert(parts, sign .. tostring(coeff) .. "k")
                end
            end
            
            if #parts == 0 then
                return "0"
            end
            
            -- Add + signs between parts if needed
            local result = parts[1]
            for i = 2, #parts do
                local part = parts[i]
                if not string.match(part, "^[%-%+]") then
                    result = result .. "+" .. part
                else
                    result = result .. part
                end
            end
            
            return result
        end,
        __index = {
            coefficients = function(self)
                return {self.a, self.b, self.c, self.d}
            end,
            conjugate = function(self)
                return class.new(self.a, -self.b, -self.c, -self.d)
            end
        }
    }
    
    class.new = function (a, b, c, d)
        return setmetatable({
            a = a or 0,
            b = b or 0,
            c = c or 0,
            d = d or 0
        }, meta)
    end
    
    return class
end)({})
