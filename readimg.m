%! Example of reading an image, rotating it, and digitizing data from it.
% University of Tenneseee : Will Schleter : December, 2006
function main
clc
close all
 
% get and format image
url='http://ef.engr.utk.edu/ef230-2009-08/modules/misc/data/';
file='fig1.jpg';
urlwrite([url file],file);
im = imread(file);
img = imgrey(im);
colormap(gray(256));
image(img);
hold on;
 
% get calibration points
uiwait(msgbox(['The first step is to digitize the origin, xmax, and ymax points on the axes.']));
origin=getpoint('origin','0,0');
xmax=getpoint('x max','25,0');
ymax=getpoint('y max','0,1');
 
% rotate and display new image
dy=xmax(1,2)-origin(1,2);
dx=xmax(1,1)-origin(1,1);
ang=atand(dy/dx);
imr=rotate_image(ang,img);
clf;
image(imr);
hold on;
 
% get new origin and digitized points
% origin is required again because the img has been rotated
[o2,xys] = getcurve();
  
% display calibration points on rotated image
 plot([o2(1)+dx o2(1)],[o2(2) o2(2)+ymax(1,2)-origin(1,2)],'b*');
 
% calculate curve values and display table
xyg=scale(xys,o2,origin,xmax,ymax);
txt1=sprintf('Time(hrs)   Concentration\n')
txt2=sprintf('%8.2f   %8.2f\n',xyg');
msgbox([txt1 txt2]);
return
 
function r=scale(xy,o2,o,x,y)
% input: digitized curve points (xy) and calibration points
% output: curve points converted to graph's coordinate system
xs=(x(2,1)-o(2,1))/(x(1,1)-o(1,1));
ys=(y(2,2)-o(2,2))/(y(1,2)-o(1,2));
r(:,1) = ( xy(:,1)-o2(1,1) ).*xs + o(2,1);
r(:,2) = ( xy(:,2)-o2(1,2) ).*ys + o(2,2);
return
 
function r=imgrey(im)
% input: rgb image
% output: greyscale image
r=.2989*im(:,:,1)...
    +.5870*im(:,:,2)...
    +.1140*im(:,:,3);
return
         
function r=getpoint(p,d)
% digitize a point and prompt for associated xy coordinates
title(['Digitize the ' p]);
[x y]=ginput(1);
r(1,:) = [x y];
plot(x,y,'ro');
a = inputdlg(['Enter coordinates for ' p ],'',1,{d});
r(2,:)=sscanf(char(a),'%f,%f');
return
 
function [o2,r]=getcurve()
% get new origin and digitized curve points
butt=0;
ii=-1;
hold on;
uiwait(msgbox('Digitize origin then curve points with left mouse button, click the right mouse button to end selection'));
while (butt~=3)
    if ii==-1
        title('Digitize the origin');
    else
        title(sprintf('Digitize curve point #%u, right click to quit.',ii+1));
    end
    [x,y,butt] = ginput(1);
    if butt==1
        ii=ii+1;
        if (ii==0) % first point is origin
            o2=[x,y];
            plot(x,y,'ro')
        else % other points are curve points
            r(ii,:)=[x,y];
            plot(x,y,'r*')
        end
    end
end
title('Digitizing finished');
return
 
 function out_image_m = rotate_image( degree, in_image_m )
%
% rotate_image - rotates an image given inside a matrix by the amount of "degree" counter-clockwise
%                using linear interpolation of the output grid points from the back-rotated input points
%                in this way, the output image will never have a "blank" point
%
% Format:   [out_image_m,out_ref_points_m] = rotate_image( degree, in_image_m, in_ref_points_m )
%
% Input:    degree          - rotation degree in dergees, counter-clockwise
%           in_image_m      - input image, given inside a matrix (gray level image only)
% 
% Output:   out_image_m      - the output image
%  
% NOTE:     By definition of rotation, in order to perserve all the image inside the
%           rotated image space, the output image will be a matrix with a bigger size. 
%
% wrap input image by zeros from all sides
in_image_m = double(in_image_m);
zeros_row    = zeros(1,size(in_image_m,2)+2);
zeros_column = zeros(size(in_image_m,1),1);
in_image_m   = [zeros_row; zeros_column,in_image_m,zeros_column; zeros_row ];
 
% build the rotation matrix
degree_rad = degree * pi / 180;
R = [ cos(degree_rad), sin(degree_rad); sin(-degree_rad) cos(degree_rad) ];
 
% input and output size of matrices (output size is found by rotation of 4 corners)
in_size_x       = size(in_image_m,2);
in_size_y       = size(in_image_m,1);
in_mid_x        = (in_size_x-1) / 2;
in_mid_y        = (in_size_y-1) / 2;
in_corners_m    = [ [0,0,in_size_x-1,in_size_x-1] - in_mid_x;
                    [0,in_size_y-1,in_size_y-1,0] - in_mid_y ];
out_corners_m   = R * in_corners_m;
 
% the grid (integer grid) of the output image and the output image
[out_x_r,out_y_r]   = rotated_grid( out_corners_m );
out_size_x          = max( out_x_r ) - min( out_x_r ) + 1;
out_size_y          = max( out_y_r ) - min( out_y_r ) + 1;
out_image_m         = zeros( ceil( out_size_y ),ceil( out_size_x ) );
out_points_span     = (out_x_r-min(out_x_r))*ceil(out_size_y) + out_y_r - min(out_y_r) + 1;
     
% % for debug
% out_image_m(out_points_span) = 1;
% return;
% % end of for debug
 
% the position of points of the output grid in terms of the input grid
in_cords_dp_m   = inv(R) * [out_x_r;out_y_r];
 
x_span_left     = floor(in_cords_dp_m(1,:) + in_mid_x + 10*eps );
y_span_down     = floor(in_cords_dp_m(2,:) + in_mid_y + 10*eps );
x_span_right    = x_span_left + 1;
y_span_up       = y_span_down + 1;
dx_r            = in_cords_dp_m(1,:) - floor( in_cords_dp_m(1,:) + 10*eps );
dy_r            = in_cords_dp_m(2,:) - floor( in_cords_dp_m(2,:) + 10*eps );
 
point_span_0_0  = x_span_left*ceil(in_size_y)  + y_span_down + 1; % position of combined index in output matrix
point_span_1_0  = x_span_left*ceil(in_size_y)  + y_span_up + 1;
point_span_0_1  = x_span_right*ceil(in_size_y) + y_span_down + 1;
point_span_1_1  = x_span_right*ceil(in_size_y) + y_span_up + 1;
 
out_image_m(out_points_span) = ...
    in_image_m( point_span_0_0 ).*(1.0-dx_r).*(1.0-dy_r) + ...
    in_image_m( point_span_1_0 ).*(1.0-dx_r).*(  dy_r) + ...
    in_image_m( point_span_0_1 ).*(  dx_r).*(1.0-dy_r) + ...
    in_image_m( point_span_1_1 ).*(  dx_r).*(  dy_r);
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              Inner function implementation                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function [x_r,y_r] = rotated_grid( rect_points_m )
%
% rotated_grid - creates a grid of points bounded inside a rotated RECTANGLE
%
% Format:   [x_m,y_m] = rotated_grid( rect_points_m )
%
% Input:    rect_points_m   -   a set of (x;y) points which define a rectangle ordered clock-wise
%                               ( format: [x1,x2,x3,x4;y1,y2,y3,y4] )
%
% Output:   x_r,y_r         -   2 row vectors which hold the x and y positions of 
%                               the output grid
% 
% NOTE:     THE ASSUMPTION IS THAT THE RECTANGLE IS ORDERED CLOCK-WISE !!!
%           AND THAT THE GIVEN CO-ORDINATES ARE A RECTANGLE !
%
 
 
% make sure that the first point of the clock-wise-ordered rectange is of the most left point
[temp,idx] = min( rect_points_m(1,:) );
if ( idx > 1 )
    rect_points_m = [ rect_points_m(:,idx:end) , rect_points_m(:,1:idx-1) ];
end
 
% put into variables so it is easier to access/read the numbers
x1 = rect_points_m(1,1);
x2 = rect_points_m(1,2);
x3 = rect_points_m(1,3);
x4 = rect_points_m(1,4);
y1 = rect_points_m(2,1);
y2 = rect_points_m(2,2);
y3 = rect_points_m(2,3);
y4 = rect_points_m(2,4);
 
% initialization for grid creation
clipped_top     = floor( y2 );
clipped_bottom  = ceil( y4 );
fraction_bottom = clipped_bottom - y4;
rows            = ( clipped_top - clipped_bottom );
left_crossover  = y1 - y4;
right_crossover = y3 - y4;
 
% calculate the position of the edges (left and right) along the y axis
m = [0:rows] + fraction_bottom ;
switch (y1)
case y2, x_left = repmat( ceil( x4 ),size(m) );
case y4, x_left = repmat( ceil( x2 ),size(m) );
otherwise
    x_left = ( m >= left_crossover ).*ceil( x2 - (x1-x2)/(y1-y2)*(rows-m+2*fraction_bottom) ) + ...
        ( m < left_crossover ).*ceil( x4 + (x1-x4)/(y1-y4)*m );
end
switch (y3)
case y2,    x_right = repmat( floor( x4 ),size(m) );
case y4,    x_right = repmat( floor( x2 ),size(m) );
otherwise
    x_right = ( m >= right_crossover ).*floor( x2 - (x3-x2)/(y3-y2)*(rows-m+2*fraction_bottom) ) + ...
        ( m < right_crossover ).*floor( x4 + (x3-x4)/(y3-y4)*m );
end
       
% build the output vectors (initialize)      
vec_length = sum(x_right-x_left+1);
x_r = zeros(1,vec_length );
y_r = zeros(1,vec_length );
 
% build the grid into the output vectors
cursor = 1;
for n = 1:length(m)
    if ( x_right(n) >= x_left(n) )
        span        = cursor:(x_right(n) - x_left(n) + cursor);
        x_r( span ) = x_left(n):x_right(n);
        y_r( span ) = m(n) + y4;
        cursor      = cursor + x_right(n) - x_left(n) + 1; 
    end
end