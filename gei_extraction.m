
% Initializing silhouettes path
folders_path = ".\Silhouettes";
folders = dir(folders_path);
folders = folders(~ismember({folders(:).name},{'.','..'}));

for index = 1 : numel(folders)
    
    image_path = folders_path + "\" + folders(index).name
    files = dir(fullfile(image_path, '*.png'));
    total_image = zeros(350, 350);


    % Going over each silhouette image
    for i = 1 : numel(files)
        path = fullfile(image_path, files(i).name);
        image = imread(path);

        % Cropping out the individual
        props = regionprops(image, 'BoundingBox');
        thisBB = props(length(props)).BoundingBox;
        image = imcrop(image, thisBB);

        % Resizing image by padding
        x_size = fix((350 - thisBB(3)) / 2);
        y_size = fix((350 - thisBB(4)) / 2);
        image = padarray(image, [y_size x_size]);
        image = imresize(image, [350 350]);
        
        % Adding to total
        total_image = total_image + double(image);

    end

    % Calculating GEI
    gei = total_image ./ number_images;
    gei = mat2gray(gei);
    write_path = image_path + "\" + folders(index).name + "_GEI.png";
    imwrite(gei, write_path, 'png');
    
end