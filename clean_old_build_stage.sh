#!/bin/sh
WORKDIR=/data/releases

ALL_APP=("qz_api_sales_" "qz_api_three_party_" "qz_api_ygj_" "qz_api_zxs_api.qizuang.com_" "qz_api_zxs_zxs.api.qizuang.com_" "qz_hzs_" "qz_jjdg_admin_" "qz_marketing_page_" "qz_mobile_" "qzmsg_" "qz_rwc_admin-ui_" "qz_rwc_user-ui_" "qz_service_admin_api_" "qz_service_admin_ui_" "qz_service_chouci_" "qz_service_fenci_" "qz_service_passport_" "qz_service_qzmsg_" "qz_service_qzsms_" "qz_service_qzws_" "qz_service_search_" "qzsms_" "qz_tools_" "qz-tools_" "qz_u_new_" "qz_user_" "qz_user_center_account_" "qz_user_center_space_" "qz-user-cp-ui_" "qz_user_jiaju_" "qz-user-web_" "qzws_" "qzwww_" "qz_www_jiaju_" "qz_yxb_" "qz_zxs_h5_h5.qizuang.com_" "qz_zxs_h5_zxs.h5.qizuang.com_legacy_" "ruanwen-user-ui_" "sales-api_" "search_" "task_" "three-party-api_" "Ucenter-account-web_" "Ucenter-space-web_" "www-web_" "zxs-api_" "zxs-h5-ui_")

function clean_old_build_stage(){
    # echo "所有项目：${ALL_APP[@]}"
    for i in ${ALL_APP[@]};do
        # echo -e "当前项目：${i%?}"
        appnum=`ls ${WORKDIR} | grep -Eo ${i}\([0-9].*?\) | wc -l` #取出当前项目包含的构建数量
        time=`ls -tl ${WORKDIR} | grep -E ${i}\([0-9].*?\) | awk '{print $8}' | uniq | wc -l` #取出当前项目中代码更改的构建数量
        echo -e "\n当前项目构建数：${appnum}\n"
        echo -e "\n不同创建时间的构建数：${time}\n"
        if [ ${appnum} -gt 5 ]; then #只对构建数超过5个的项目进行操作
            if [ ${time} -gt 3 ]; then #只对代码更改超过3次的项目进行操作
            del_appnum=`expr ${appnum} - 5` #判断需要删除的构建数量
            # echo -e "待删除数量：${del_appnum}\n"
            del_applist=`ls -tr ${WORKDIR} | grep -Eo ${i}\([0-9].*?\) | head -${del_appnum}` #列出需要删除的构建的列表
            # echo -e "`date '+%d/%b/%Y %H:%M:%S'` "
            echo -e "`date '+%d/%b/%Y %H:%M:%S'` 需要清理如下构建项目:\n${del_applist}"
            echo -e "\n`date '+%d/%b/%Y %H:%M:%S'` "
                for list in ${del_applist}; do
                    echo -e "正在清理的的构建 ${list}..."
                    cd ${WORKDIR} && rm -rf ${list}
                done
            fi
        fi
        sleep 1
    done
}

main(){
    if [ -d ${WORKDIR} ];then #判断目录是否为空，为空则清理
        empty_dir=`find ${WORKDIR} -mindepth 1 -maxdepth 1 -type d -empty`
        # echo -e "\n空文件夹列表：$empty_dir"
        for i in ${empty_dir}; do
            echo -e "正在删除空目录${i}..."
            rm -r ${i}
        done
        clean_old_build_stage
    fi
}
# echo -e "执行时间：`date '+%Y-%m-%d %H:%M:%S'`\n"
main