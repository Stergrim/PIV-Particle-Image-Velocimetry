function preprocessing(Storage)
%preprocessing Предобработка изображений
%   Выполняет перевод из цветного в черно-белое и приведение к типу данных double.
%   Подразумевается, что исходные изображения одинаковые по размеру

size_image = size(Storage.src_image_1);

% Перевод цветных изображений в черно-белые и запись в класс Storage
if (size(size_image,2) == 3) & (size_image(3) > 1)
    Storage.image_1 = rgb2gray(Storage.src_image_1);
    Storage.image_2 = rgb2gray(Storage.src_image_2);
else
    Storage.image_1 = Storage.src_image_1;
    Storage.image_2 = Storage.src_image_2;
end

% Приведение к типу данных double
if ~isa(Storage.image_1,'double')
    Storage.image_1 = double(Storage.image_1);
    Storage.image_2 = double(Storage.image_2);
end

end