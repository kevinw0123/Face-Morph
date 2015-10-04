function [ color ] = interpolate(img, x, y)

    [w, h, ~] = size(img);

    if x < 1
        x = 1;
    elseif x >= w
        x = w - 1;
    end
    if y < 1
        y = 1;
    elseif y >= h
        y = h - 1;
    end
    
    a = img(floor(x)    , floor(y)    , :);
    b = img(floor(x) + 1, floor(y)    , :);
    c = img(floor(x)    , floor(y) + 1, :);
    d = img(floor(x) + 1, floor(y) + 1, :);
    
    xcord = x - floor(x);
    ycord = y - floor(y);
    
    color = a*(1-xcord)*(1-ycord) + b*xcord*(1-ycord) + c*(1-xcord)*ycord + d*xcord*ycord;
end

