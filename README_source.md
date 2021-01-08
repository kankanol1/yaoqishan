# 文件保存路径说明

## 上传文件，文件前缀作为最有一级文件夹，

文件保存目录为 `/var/www/website/upload/文件名`

自动创建 抽帧图片路径`/var/www/website/upload/文件名/input`

自动创建 编译图片路径`/var/www/website/upload/文件名/output`

压缩包路径`/var/www/website/upload/`

## 例如上传文件为`test.mp4`

系统创建

视频路径 `/var/www/website/upload/test/test.mp4`

抽帧图片 `/var/www/website/upload/test/input/`

编译图片 `/var/www/website/upload/test/output/`

压缩包路径（和视频同级目录） `/var/www/website/upload/test/`


## 说明
将抽帧图片保存在`input`路径下，编译图片保存在`output`路径下，压缩包保存在视频同级目录下即可