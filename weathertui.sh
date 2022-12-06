#!/bin/sh

# This file is used to show weather different area(cities in coutries)

cmd="curl wttr.in/"

locat_cn=("ZheJiang", "ChongQing", "JiangXi", "HeiBei", "ShaanXi", "ShanXi", "BeiJing", "ShangHai", "QingHai", "NanJing", "JiLing", "AnQing", "SiChuan" "YunNan", "Tibet", "LiaoNing", "GanSu", "FuJian", "GuiZhou", "GanSu", "NingXia", "HeiLongJiang", "TaiWan", "HongKong", "Macau", "HaiNan", "JiangSu")

len_cn=${#locat_cn[*]}

while [[ 1 ]]; do
    for (( i=0; i<$len_cn; i++ )); do
	clear -x
	$cmd"${locat_cn[$i]}"
	sleep 150s
    done
done
    
