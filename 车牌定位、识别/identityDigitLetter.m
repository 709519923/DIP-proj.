function result = identityDigitLetter(DigitLetter, ch)
[height,width, num] = size(DigitLetter);
for n=1:num
    sums = 0;
    for h=1:height
        for w=1:width
            if ch(h,w) == DigitLetter(h,w,n)
                sums = sums + 1;
            end
        end
    end
    ratio(n) = sums/(height*width);
end
result_index = find(ratio>=max(ratio));
if result_index<=10
    base = 47;
    result = char(base + result_index);
else
    base = 64;%×ÖÄ¸¿ªÊ¼
    result = char(base + result_index);
end
end
