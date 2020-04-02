
% Initializing path for dataset images
folders_path = ".\Dataset_A";
background_path = ".\Background_Images\";
folders = dir(folders_path);
folders = folders(~ismember({folders(:).name},{'.','..'}));

for index = 1 : numel(folders)
    
    % Generating folder number for background image
    number = folders(index).name;
    number = number(strlength(number))
    
    % Generating folder name to insert into file name
    file_name = folders(index).name;
    file_name = file_name(1: strlength(file_name) - 1)
    
    % Opening the background image from the generated folder
    back_path = background_path + file_name + "-00_" + number + "-bk.png";
    back_image = imread(back_path);
    back_image = rgb2gray(back_image);
    back_image = double(back_image);

    % Preparing the read paths for the images for each sequence
    images_path = folders_path + "\" + folders(index).name;
    files = dir(fullfile(images_path, '*.png'));
    
    % Creating the directory for storing the silhouettes
    mkdir('.\Silhouettes', folders(index).name);

    % Getting all the images from the directory
    for i = 1 : numel(files)
        path = fullfile(images_path, files(i).name);
        image = imread(path);
        a = rgb2gray(image);
        b = back_image;

        a = double(a);
        b = double(b);

        term_1 = 2 * sqrt((a + 1) .* (b + 1)) ./ ((a + 1) + (b + 1));
        term_2 = 2 * sqrt((256 - a) .* (256 - b)) ./ ((256 - a) + (256 - b));
        result = 1 - (term_1 .* term_2);

        [counts, ~] = imhist(result, 50);
        threshold_value = double(otsuthresh(counts));
        result = imbinarize(result, threshold_value);
        
        % Writing the background image to the specified folder
        write_path = ".\Silhouettes\" + folders(index).name + "\" + files(i).name;
        imwrite(result, write_path, 'png');
        
    end

end



