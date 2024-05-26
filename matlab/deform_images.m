function deform_images(Storage,deform_type)

% Масштабирование векторного поля
Storage.vectors_map_last_pass = imresize(Storage.vectors_map_last_pass,size(Storage.image_1),'bilinear');

switch deform_type
    case 'symmetric'
        Storage.image_1 = imwarp(Storage.image_1,-Storage.vectors_map_last_pass/2,'cubic');
        Storage.image_2 = imwarp(Storage.image_2,Storage.vectors_map_last_pass/2,'cubic');
    case 'second'
        Storage.image_2 = imwarp(Storage.image_2,Storage.vectors_map_last_pass,'nearest');
    otherwise , error('Указан неизвестный метод');
end

end