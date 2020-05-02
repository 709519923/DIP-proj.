function result = identityChinese(Chinese, ch)
[height,width, num] = size(Chinese);
for n=1:num
    sums = 0;
    for h=1:height
        for w=1:width
            if ch(h,w) == Chinese(h,w,n)
                sums = sums + 1;
            end
        end
    end
    ratio(n) = sums/(height*width);
end
result_index=find(ratio>=max(ratio));
c = {'»¦','¼ª','¾©','Ãö','ËÕ','ÔÁ','Õã'};
result = cell2mat(c(result_index));
end
