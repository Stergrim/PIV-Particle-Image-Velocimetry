function subpixel_peak(Storage,varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Определиние стандартных параметров
eps = 1e-7;
method = 'gaussian';

% Запись переданных параметров
k = 2;
while k <= size(varargin,2)
    switch varargin{k-1}
        case 'method'
            method = varargin{k};
        otherwise
            error('Указан неизвестный параметр');
    end
    k = k + 2;
end

Storage.vectors_map = Storage.vectors_map - Storage.vectors_map_last_pass;

[H,W] = size(Storage.vectors_map_last_pass,1:2);
for i = 1:H
    for j = 1:W
        x_peak = Storage.vectors_map_last_pass(i,j,1) + Storage.window_size(2);
        y_peak = Storage.vectors_map_last_pass(i,j,2) + Storage.window_size(1);
        if ((x_peak_1 == 1)||(y_peak_1 == 1)||(x_peak == 2*Storage.window_size(2)-1)||(y_peak == 2*Storage.window_size(1)-1))
            Storage.vectors_map(i,j,:) = Storage.vectors_map(i,j,:) + Storage.vectors_map_last_pass(i,j,:);
        else
            Storage.correlation_maps{i,j} = Storage.correlation_maps{i,j} + eps;
            center = Storage.correlation_maps{i,j}(y_peak,x_peak);
            left = Storage.correlation_maps{i,j}(y_peak,x_peak-1);
            right = Storage.correlation_maps{i,j}(y_peak,x_peak+1);
            down = Storage.correlation_maps{i,j}(y_peak+1,x_peak);
            up = Storage.correlation_maps{i,j}(y_peak-1,x_peak);

            switch method
                case 'gaussian'
                    num_x = log(left) - log(right);
                    den_x = 2*log(left) - 4*log(center) + 2*log(right);
                    num_y = log(down) - log(up);
                    den_y = 2*log(down) - 4*log(center) + 2*log(up);
                    if den_x ~= 0, x_peak = x_peak + num_x/den_x; end
                    if den_y ~= 0, y_peak = y_peak + num_y/den_x; end
                case 'centroid'
                    x_peak = ((x_peak - 1)*left + x_peak*center + (x_peak + 1)*right)/(left + center + right);
                    y_peak = ((y_peak - 1)*down + y_peak*center + (y_peak + 1)*up)/(down + center + up);
                case 'parabolic'
                    x_peak = x_peak + (left - right)/(2*left - 4*center + 2*right);
                    y_peak = y_peak + (down - up)/(2*down - 4*center + 2*up);
                otherwise
                    error('Указан неизвестный метод');
            end
            Storage.vectors_map_last_pass(i,j,:) = [x_peak,y_peak];
        end
    end
end

Storage.vectors_map = Storage.vectors_map + Storage.vectors_map_last_pass;

end