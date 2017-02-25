# Easy Install

这个repo主要是帮助大家快速高效地安装常用库, 帮助大家节省时间. 有时候正事还没开始做安装一些工具弄得焦头烂额, 这样的体验简直不要太伤心.

## OpenCV
`install-opencv.sh`这个shell脚本用来从源码安装[OpenCV](http://opencv.org/)库. 主要前面一部分

    sudo apt-get install -y build-essential cmake
    sudo apt-get install -y libvtk6-dev qt5-default
    sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev
    ...

这些是在安装opencv所需的一些依赖库和build OpenCV所需的一些工具.

然后`wget https://github.com/opencv/opencv/archive/3.2.0.zip`这里是在从github下载OpenCV源码, 国内的朋友们从github下载有点慢的话, 我有一个备选的源但是注释了, 你可以换上`wget http://data-10045577.cos.myqcloud.com/opencv-3.2.0.zip`.

最后在CMAKE的时候有很多选项:`cmake -DWITH_IPP=OFF -DWITH_CUDA=OFF -DWITH_QT=OFF -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_OPENMP=ON -DWITH_GDAL=OFF -DWITH_XINE=ON -DBUILD_EXAMPLES=OFF  BUILD_DOCS=OFF ..`, 这里我关了很多, 因为我发现平常不太用. 特别是`cuda`我建议关掉, 因为编译起来太慢而且平常也不太用, 另外这个`IPP`我发现打开之后CMAKE的时候有个东西老是下载不下来, 所以我也关了.

## Caffe
`install-caffe.sh`这个用来安装[caffe](http://caffe.berkeleyvision.org/). 有几点说明:

1. 不推荐使用`sudo apt-get install libopencv-dev`来安装OpenCV, 原因是这样安装之后并没有安装OpenCV的python接口, 当你想在python中`import cv2`的时候就无法使用, 这时候你又得用`sudo apt-get install python-opencv`来安装OpenCV的python接口, 这个是**极不推荐的**,原因后面会讲;

2. 不推荐使用`sudo apt-get install python-numpy`安装*numpy*, 原因和 1. 中一样;

## 为什么不推荐用apt-get安装python包

上面1)和2)中都提到不推荐使用`apt-get install python-xxx`来安装python包, 为什么呢?

* apt-get 中的包更新的都很慢, 版本很低, 而python package更新又是很快的, 这会导致你安装的很多package都是out of date的;

* 当你在网上查到了一个叫`pip install xx`的命令可以来安装比较新的版本的python package的时候, 因为`apt-get install`和`pip install`各自安装的package的版本兼容和路径问题, 灾难就开始了.

所以在这里强烈建议统一使用[**pip**](https://pip.pypa.io/en/stable/)来管理python package, 不要使用`apt-get install python-xx`.

在[install-caffe.sh](https://github.com/zeakey/ez-install/blob/master/install-caffe.sh#L16-L18)中
```bash
if [ $(which pip) == '' ]; then
  curl https://bootstrap.pypa.io/get-pip.py | sudo -H python
fi
```
会给您安装**pip**包管理器.

## pip的简单用法

* `pip install xxx` 安装
* `pip uninstall xxx` 卸载
* `pip search xx` 查找
* `pip list` 列出已安装

**注意以上命令如果提示权限问题, 请加 `sudo -H`解决**
____
欢迎大家提意见, 使用发现bug请提[issue](https://github.com/zeakey/ez-install/issues).

Best,
[Kai](http://zhaok.xyz/)
