D ='./train_gei';
S = dir(fullfile(D,'*.png')); % pattern to match filenames.
training_list = zeros(60,(152*114));
testing_list = zeros(20, (152*114));
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    I=imcrop(I,[118.5 102.5 113 151]);
    %imshow(I);
    training_list(k,:) = I(:);
end
D ='./test_gei';
S = dir(fullfile(D,'*.png')); % pattern to match filenames.
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    I=imcrop(I,[118.5 102.5 113 151]);
    testing_list(k,:)=I(:);
end
grouptrain=[1;1;1;2;2;2;3;3;3;4;4;4;5;5;5;6;6;6;7;7;7;8;8;8;9;9;9;10;10;10;11;11;11;12;12;12;13;13;13;14;14;14;15;15;15;16;16;16;17;17;17;18;18;18;19;19;19;20;20;20];
%results = multisvm(training_list,grouptrain,testing_list);
%Mdl = fitrsvm(training_list,grouptrain);
%yfit = predict(Mdl,testing_list);
Mdl = fitcknn(training_list,grouptrain,'NumNeighbors',7,'Standardize',1);
yfit = predict(Mdl,testing_list);