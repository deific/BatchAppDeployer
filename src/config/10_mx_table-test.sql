/*
 * ===========================================================
 *   script name:      模型库相关建表脚本                                
 *   database name:    m_gjj                                         
 *   dbms name:        mysql version 5.1                         
 *   created on:                                                       
 *   last modified on: 2011-10-11 10:50                             
 *   designed by:      王建中                                       
 *   created by:       王建中                                 
 * ===========================================================
 */

/*
创建模型库
*/
create database if not exists `m_gjj-test`;
use `m_gjj-test`;
seta names gbk;

/*
 * ===========================================================
 *   table：data_incremen
 *   汉字名称:增量标记表
 *   创建人：  庞艳蕊
 *   创建日期：2011.10.18
 *   修改人：陈世刚
 *   修改日期：2011.12.26
 *   修改内容：调整表结构
 * ===========================================================
 */
drop table if exists `data_increment`;
create table `data_increment` (
  `id`		int(15)		not null auto_increment		comment 'id',
  `sql_id`	varchar(200)	not null			comment '当前抓取数据表的sql_id',
  `createtime`	char(50)	not null			comment '创建时间',
  `updatetime`	char(50)	not null			comment '更新时间',
  `finishcount` char(50)	not null			comment '已抓取的数据条数',
  `remark`	char(100)	not null			comment '备注，默认为当前sql语句对应的表名',
  primary key (`id`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：gjjjg_m_cw_cwmxz
 *   汉字名称: 财务明细账
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_cw_cwmxz`;
create table `gjjjg_m_cw_cwmxz` (
  `id`          int(15)         not null auto_increment          comment '主键id',
  `zxbhdm`      char(15)        default null                     comment '中心编号代码',
  `cjsj`        date            default null                     comment '创建时间',
  `jgh`         char(50)        default null                     comment '创建时间',
  `kmbh`        char(18)        default null                     comment '科目编号',
  `ny`          char(6)         default null                     comment '年月',
  `cnlsh`       char(50)        default null                     comment '年月',
  `lx`          char(2)         default null                     comment '类型',
  `jzrq`        char(8)         default null                     comment '记账日期',
  `zy`          varchar(200)    default null                     comment '摘要',
  `jdfx`        char(6)         default null                     comment '借贷方向',
  `jffse`       decimal(18,2)   default null                     comment '借方发生额',
  `dffse`       decimal(18,2)   default null                     comment '贷方发生额',
  `ye`          decimal(18,2)   default null                     comment '余额',
  `yefx`        char(6)         default null                     comment '余额方向',
  `qcye`        decimal(18,2)   default null                     comment '期初余额',
  `qcyefx`      char(6)         default null                     comment '期初余额方向',
  `dfkm`        char(18)        default null                     comment '对方科目',
  `qmye`        decimal(18,2)   default null                     comment '期末余额',
  `qmyefx`      char(6)         default null                     comment '期末余额方向',
  `byljjffse`   decimal(18,2)   default null                     comment '本月累计借方发生额',
  `byljdffse`   decimal(18,2)   default null                     comment '本月累计贷方发生额',
  `pzh`         char(50)        default null                     comment '凭证号',
  `zqbh`        char(18)        default null                     comment '债券编号',
  `dqckbh`      char(18)        default null                     comment '定期存款编号',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_cnlsh` (`cnlsh`),
  key `idx_kmbh` (`kmbh`),
  key `idx_jdfx` (`jdfx`)
) engine=innodb default charset=gbk comment='财务明细帐表';

/*
 * ===========================================================
 *   table：gjjjg_m_cw_dqckmxxx
 *   汉字名称: 定期存款明细信息
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_cw_dqckmxxx`;
create table `gjjjg_m_cw_dqckmxxx` (
  `id`          int(15)         not null auto_increment          comment '主键id',
  `zxbhdm`      char(15)        default null                     comment '中心编号代码',
  `cjsj`        date            default null                     comment '创建时间',
  `jgh`         char(50)        default null                     comment '机构号',
  `dqckbh`      char(18)        default null                     comment '定期存款编号',
  `zqmc`        varchar(100)    default null                     comment '定期存款名称',
  `khyh`        varchar(100)    default null                     comment '开户银行',
  `yhzh`        varchar(40)     default null                     comment '银行账号',
  `ll`          decimal(18,2)   default null                     comment '利率',
  `je`          decimal(18,2)   default null                     comment '金额',
  `ckrq`        char(8)         default null                     comment '存款日期',
  `dqrq`        char(8)         default null                     comment '到期日期',
  `qx`          int(11)         default null                     comment '期限',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_dqckbh` (`dqckbh`)
) engine=innodb default charset=gbk comment='记录定期存款的明细信息。';

/*
 * ===========================================================
 *   table：gjjjg_m_cw_kmyehzqk
 *   汉字名称: 科目余额汇总情况
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_cw_kmyehzqk`;
create table `gjjjg_m_cw_kmyehzqk` (
  `id`          int(15)         not null auto_increment          comment '主键id',
  `zxbhdm`      char(15)        default null                     comment '中心编号代码',
  `cjsj`        date            default null                     comment '创建时间',
  `ny`          char(6)         default null                     comment '年月',
  `kmdm`        char(50)	default null			 comment '科目代码',
  `kmmc`        char(50)        default null                     comment '科目名称',
  `qcye`        decimal(18,2)   default null			 comment '期初余额',
  `jf`		decimal(18,2)	default null			 comment '借方发生额',
  `df`		decimal(18,2)	default null			 comment '贷方发生额',
  `qmye`	decimal(18,2)   default null			 comment '余额',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_kmdm` (`kmdm`)
) engine=innodb default charset=gbk comment='科目余额汇总情况';

/*
 * ===========================================================
 *   table：gjjjg_m_cw_pzfl
 *   汉字名称: 凭证分录表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_cw_pzfl`;
create table `gjjjg_m_cw_pzfl` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `cnlsh`	char(50)	default null                     comment '出纳流水号',
  `pzh`		char(50)	default null                     comment '凭证号',
  `flbh`	varchar(100)		default null			 comment '分录编号',
  `jzrq`	char(8)		default null			 comment '记账日期',
  `zy`		char(60)	default null			 comment '摘要',
  `zzkm`	char(30)	default null			 comment '总账科目',
  `mxkm`	char(30)	default null			 comment '明细科目',
  `jfje`	decimal(18,2)	default null			 comment '借方余额',
  `dfje`	decimal(18,2)	default null			 comment '贷方金额',
  `djs`		int(15)		default null			 comment '单据数',
  `czsj` date default null comment '操作时间',
  primary key (`id`)
) engine=innodb default charset=gbk comment='凭证分录表';

/*
 * ===========================================================
 *   table：gjjjg_m_cw_zqmxxx
 *   汉字名称: 债卷明细信息
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_cw_zqmxxx`;
create table `gjjjg_m_cw_zqmxxx` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`        date		default null			 comment '创建时间',
  `jgh`		char(50)	default null			 comment '机构号',
  `zqbh`	char(18)	default null			 comment '债券编号',
  `pz`		varchar(50)	default null			 comment '品种',
  `gmfs`	varchar(50)	default null			 comment '购买渠道',
  `gzpzh`	char(50)	default null                     comment '国债凭证号',
  `zqmc`	varchar(100)	default null			 comment '债券名称',
  `khyh`	varchar(100)	default null			 comment '开户银行',
  `yhzh`	varchar(40)	default null			 comment '银行账号',
  `ll`		decimal(18,2)	default null                     comment '利率',
  `je`		decimal(18,2)	default null                     comment '金额',
  `gmzqsl`	decimal(18,2)	default null                     comment '购买债券数量',
  `gmrq`	char(8)		default null			 comment '购买日期',
  `dqrq`	char(8)		default null			 comment '到期日期',
  `qx`		int(11)		default null			 comment '期限',
  `dfzrje`	decimal(18,2)	default null			 comment '兑付转让本金',
  `dfzrrq`	char(8)		default null			 comment '兑付转让日期',
  `ye`		decimal(18,2)	default null                     comment '国债余额',
  `lxsr`	decimal(18,2)	default null			 comment '利息收入',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_zqbh` (`zqbh`)
) engine=innodb default charset=gbk comment='债卷明细信息';

/*
 * ===========================================================
 *   table：gjjjg_m_dk_dkmx
 *   汉字名称: 贷款明细
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_dk_dkmx`;
create table `gjjjg_m_dk_dkmx` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `jgh`		char(50)	default null                     comment '机构号',
  `ny`		char(6)		default null			 comment '年月',
  `jkr`		char(30)	default null			 comment '借款人',
  `ywlx`	char(3)		default null			 comment '业务类型',
  `jdbj`	char(3)		default null			 comment '借贷标记',
  `yhjgh`	char(50)	default null			 comment '银行机构号',
  `yhdkzh`	char(30)	default null			 comment '银行贷款账号',
  `jkhth`	char(50)	default null			 comment '借款合同号',
  `ffje`	decimal(18,2)	default null                     comment '发放金额',
  `grzh`	char(50)	default null                     comment '个人账号',
  `dqqs`	int(11)		default null			 comment '当期期数',
  `bqyhbj`	decimal(18,2)	default null                     comment '本期应还款本金',
  `bqyhlx`	decimal(18,2)	default null                     comment '本期应还款利息',
  `bqyhfxje`	decimal(18,2)	default null                     comment '本期应还罚息金额',
  `bqyhjehj`	decimal(18,2)	default null                     comment '本期应还金额合计',
  `ssrq`	char(8)		default null			 comment '实收日期',
  `ssbj`	decimal(18,2)	default null                     comment '实收本金',
  `sslx`	decimal(18,2)	default null			 comment '实收利息',
  `ssfx`	decimal(18,2)	default null                     comment '实收罚息',
  `bqshjehj`	decimal(18,2)	default null                     comment '本期实还金额合计',
  `ffye`	decimal(18,2)	default null			 comment '贷款余额',
  `ysrq`	char(8)		default null			 comment '应收日期',
  `rzry`	char(30)	default null			 comment '入账人员',
  `rzrq`	char(8)		default null			 comment '入账日期',
  `cnlsh`	char(50)	default null			 comment '出纳流水号',
  `hkzt`	char(3)		default null			 comment '还款状态',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_cnlsh` (`cnlsh`),
  key `idx_jkhth` (`jkhth`)
) engine=innodb auto_increment=1807 default charset=gbk comment='贷款明细表';

/*
 * ===========================================================
 *   table：gjjjg_m_dk_dkyqdj
 *   汉字名称: 贷款逾期登记
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_dk_dkyqdj`;
create table `gjjjg_m_dk_dkyqdj` (
  `id`		int(11)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `jgh`		char(50)	default null                     comment '机构号',
  `jkhth`	char(50)	default null                     comment '借款合同号',
  `yqqc`	int(11)		default null			 comment '逾期期次',
  `yqbj`	decimal(18,2)	default null			 comment '逾期本金',
  `yqxl`	decimal(18,2)	default null			 comment '逾期利息',
  `yhrq`	char(8)		default null			 comment '应还日期',
  `hkrq`	char(8)		default null			 comment '实收日期',
  primary key (`id`),
  unique key `index_id` (`id`),
  key `index_zxbhdm` (`zxbhdm`),
  key `index_jgh` (`jgh`),
  key `index_jkhth` (`jkhth`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：gjjjg_m_dk_grdkqk
 *   汉字名称: 个人贷款情况
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_dk_grdkqk`;
create table `gjjjg_m_dk_grdkqk` (
  `id`		int(11)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `jkrxm`	varchar(50)	default null			 comment '借款人姓名',
  `jkrhm`	char(18)	default null			 comment '借款人证件号码',
  `jkrzjlx`	char(2)		default null			 comment '借款人证件类型',
  `jkrcsny`	date		default null			 comment '借款人出生年月',
  `jkrdzxx`	char(255)	default null			 comment '借款人电子邮箱',
  `jkrhyzk`	char(2)		default null			 comment '借款人婚姻状况',
  `jkrjtdh`	char(20)	default null			 comment '借款人家庭电话',
  `jkrjtzz`	char(255)	default null			 comment '借款人家庭住址',
  `jkrxb`	char(2)		default null			 comment '借款人性别',
  `jkrxl`	char(2)		default null			 comment '借款人学历',
  `jkryb`	char(6)		default null			 comment '借款人邮编',
  `jkrzz`	char(2)		default null			 comment '借款人职称',
  `jkrzw`	char(2)		default null			 comment '借款人职务',
  `jkrzy`	char(2)		default null			 comment '借款人职业',
  `jlrcdgx`	char(2)		default null			 comment '借款人参贷关系',
  `jkrsbzh`	char(50)	default null			 comment '借款人社保账号',
  `jkrgrsr`	decimal(18,2)	default null			 comment '借款人个人月收入',
  `jkrjtsr`	decimal(18,2)	default null			 comment '借款人家庭月收入',
  `jkrxydj`	char(10)	default null			 comment '借款人信用等级',
  `jkrsjh`	char(20)	default null			 comment '借款人手机号',
  `dkfxdj`	char(2)		default null			 comment '贷款风险等级',
  `dkye`	decimal(18,2)	default null			 comment '贷款余额',
  `dkzhzt`	char(2)		default null			 comment '贷款账户状态',
  `dkhqrq`	date		default null			 comment '贷款还清日期',
  `ljhsbjje`	decimal(18,2)	default null			 comment '累计回收本金金额',
  `ljhslxje`	decimal(18,2)	default null			 comment '累计回收利息金额',
  `ljhsfxje`	decimal(18,2)	default null			 comment '累计回收罚息金额',
  `ljhsqs`	char(18)	default null			 comment '累计回收期数',
  `ljtqhdje`	decimal(18,2)	default null			 comment '累计提前还款金额',
  `ljyqbjje`	decimal(18,2)	default null			 comment '累计逾期本金金额',
  `ljyqlxje`	decimal(18,2)	default null			 comment '累计逾期利息金额',
  `ljyqqs`	int(11)		default null			 comment '累计逾期期数',
  `ljtqhkcs`	int(11)		default null			 comment '累计提前还款次数',
  `dqyqqs`	int(11)		default null			 comment '当前逾期期数',
  `dkhth`	char(50)	default null			 comment '贷款合同号',
  `yhdkzh`	char(30)	default null			 comment '银行贷款账号',
  `yhjgh`	char(10)	default null			 comment '贷款银行',
  `grzh`	char(50)	default null			 comment '个人账号',
  `gjjffje`	decimal(18,2)	default null			 comment '公积金发放金额',
  `gjjdkqx`	char(18)	default null			 comment '公积金贷款期限',
  primary key (`id`),
  unique key `index_id` (`id`),
  key `index_zxbhdm` (`zxbhdm`),
  key `index_grzh` (`grzh`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：gjjjg_m_dk_gtdkrxx
 *   汉字名称: 共同贷款人信息表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_dk_gtdkrxx`;
create table `gjjjg_m_dk_gtdkrxx` (
  `id`		int(11)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `jgh`		char(50)	default null			 comment '机构号',
  `dkhth`	char(50)	default null			 comment '贷款合同号',
  `gtdkrgjjzh`	char(15)	default null			 comment '共同贷款人公积金账号',
  `gtdkrxm`	char(50)	default null			 comment '共同贷款人姓名',
  `gtdkrzjlx`	char(2)		default null			 comment '共同贷款人证件类型',
  `gtdkrzjh`	char(18)	default null			 comment '共同贷款人证件号',
  `czry`	char(50)	default null			 comment '操作人员',
  `czrq`	char(8)		default null			 comment '操作日期',
  `pojcbj`	char(2)		default null			 comment '配偶外地缴存标记',
  primary key (`id`),
  unique key `index_id` (`id`),
  key `index_zxbhdm` (`zxbhdm`),
  key `index_jgh` (`jgh`),
  key `index_dkhth` (`dkhth`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：gjjjg_m_gg_ll
 *   汉字名称: 利率表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_gg_ll`;
create table `gjjjg_m_gg_ll` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `ywlx`	char(16)	default null			 comment '业务类型',
  `lllx`	char(16)	default null			 comment '利率类型',
  `ckqx`	char(60)	default null			 comment '存款期限',
  `sxrq`	date		default null			 comment '生效日期',
  `jzrq`	date		default null			 comment '截至日期',
  `tzrq`	date		default null			 comment '调整日期',
  `nll`		decimal(9,8)	default null			 comment '年利率',
  primary key (`id`)
) engine=innodb default charset=gbk comment='利率表';

/*
 * ===========================================================
 *   table：gjjjg_m_gj_dwfzmx
 *   汉字名称: 利率表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_gj_dwfzmx`;
create table `gjjjg_m_gj_dwfzmx` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `jgh`		char(50)	default null			 comment '机构号',
  `dwzh`	char(50)	default null			 comment '单位账户',
  `jyrq`	char(10)	default null			 comment '交易日期',
  `pzhm`	char(50)	default null			 comment '凭证号',
  `lsh`		char(50)	default null			 comment '流水号',
  `yhdm`	char(10)	default null			 comment '银行代码',
  `jym`		char(10)	default null			 comment '交易码',
  `cnlsh`	char(50)	default null			 comment '出纳流水号',
  `zy`		varchar(150)	default null			 comment '摘要',
  `rs`		int(15)		default null			 comment '人数',
  `fsje`	decimal(18,2)	default null			 comment '发生金额',
  `jdbj`	char(6)		default null			 comment '借贷标记',
  `ye`		decimal(18,2)	default null			 comment '余额',
  `czrq`	char(8)		default null			 comment '操作日期',
  `czy`		char(10)	default null			 comment '操作员',
  `hcbj`	char(5)		default null			 comment '红冲标记',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_cnlsh` (`cnlsh`),
  key `idx_dwzh` (`dwzh`)
) engine=innodb default charset=gbk comment='单位分户账明细表';

/*
 * ===========================================================
 *   table：gjjjg_m_gj_dwjcqkb
 *   汉字名称: 单位缴存情况表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_gj_dwjcqkb`;
create table `gjjjg_m_gj_dwjcqkb` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `dwzh`	varchar(50)	default null			 comment '单位账号',
  `dwmc`	varchar(50)	default null			 comment '单位名称',
  `grjcbl`	decimal(18,2)	default null			 comment '个人缴存比例',
  `dwjcbl`	decimal(18,2)	default null			 comment '单位缴存比例',
  `yjce`	decimal(18,2)	default null			 comment '月缴存额',
  `dwjzny`	char(6)		default null			 comment '缴至年月',
  `qjys`	int(15)		default null			 comment '欠缴月数',
  `qjje`	decimal(18,2)	default null			 comment '欠缴金额',
  `ye`		decimal(18,2)	default null			 comment '缴存余额',
  primary key (`id`)
) engine=innodb default charset=gbk comment='单位缴存情况';

/*
 * ===========================================================
 *   table：gjjjg_m_gj_dwywmx
 *   汉字名称: 单位业务明细
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_gj_dwywmx`;
create table `gjjjg_m_gj_dwywmx` (
  `id`		int(15)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `cjsj`	date		default null			 comment '创建时间',
  `dwzh`	char(50)	default null			 comment '单位帐号',
  `dzrq`	date		default null			 comment '到账日期',
  `fhrq`	date		default null			 comment '复核日期',
  `dwbnfse`	decimal(18,2)	default null			 comment '单位本年发生额',
  `dwfse`	decimal(18,2)	default null			 comment '单位发生额',
  `dwfslxe`	decimal(18,2)	default null			 comment '单位发生利息额',
  `dwsnjzfse`	decimal(18,2)	default null			 comment '单位上年结转发生额',
  `fsrs`	decimal(18,2)	default null			 comment '发生人数',
  `gjjywmxlx`	char(2)		default null			 comment '公积金业务明细类型',
  `hjny`	date		default null			 comment '汇缴年月',
  `ywrq`	date		default null			 comment '业务日期',
  `lsh`		char(50)	default null			 comment '流水号',
  `jsfs`	char(2)		default null			 comment '结算方式',
  primary key (`id`)
) engine=innodb default charset=gbk comment='单位业务明细表';

/*
 * ===========================================================
 *   table：gjjjg_m_gj_glgx
 *   汉字名称: 业务关联关系表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `gjjjg_m_gj_glgx`;
create table `gjjjg_m_gj_glgx` (
  `id`		int(11)		not null auto_increment		 comment '主键id',
  `zxbhdm`	char(15)	default null			 comment '中心编号代码',
  `ywlx`	char(2)		default null			 comment '业务类型',
  `yhid`	int(15)		default null			 comment '银行id',
  `zxid`	int(15)		default null			 comment '中心id',
  `jsid`	int(15)		default null			 comment '结算id',
  `status`	char(2)		default null			 comment '01,半关联;02,全关联;03,有风险;04,无风险;05,风险数据转移完毕;06,全关联业务不完整;10,手工对账建立关联',
  `cjsj`	date		default null			 comment '关联建立时间',
  `gzdate`	date		default null			 comment '规则扫描时间',
  `json`	longtext					 comment '全关联关系json串',
  primary key (`id`),
  unique key `index_id` (`id`),
  key `index_zxbhdm` (`zxbhdm`),
  key `index_ywlx` (`ywlx`),
  key `index_status` (`status`)
) engine=innodb default charset=gbk;

 /*
 * ===========================================================
 *   table：gjjjg_m_gj_glgx_tmp
 *   汉字名称:关联关系中间表
 *   创建人：  杨冠
 *   创建日期：2012.02.01
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_gj_glgx_tmp`;

create table `gjjjg_m_gj_glgx_tmp` (
  `zxbhdm`	char(15)	default null		comment '中心编号代码',
  `ywlx`	char(2)		default null		comment '业务类型',
  `yhid`	int(15)		default null		comment '银行id',
  `zxid`	int(15)		default null		comment '中心id',
  `jsid`	int(15)		default null		comment '结算id',
  `status`	char(2)		default null		comment '01,半关联;02,全关联;03,有风险;04,无风险;05,风险数据转移完毕;06,全关联业务不完整;10,手工对账建立关联',
  `cjsj`	date		default null		comment '建立关联时间',
  `gzdate`	date		default null		comment '规则校验时间',
  `json`	longtext	default null		comment '全关联关系json串',
  key `index_zxbhdm` (`zxbhdm`),
  key `index_ywlx` (`ywlx`),
  key `index_yhid` (`yhid`),
  key `index_zxid` (`zxid`),
  key `index_status` (`status`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：gjjjg_m_gj_grjbxx
 *   汉字名称: 个人基本信息
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_gj_grjbxx`;

create table `gjjjg_m_gj_grjbxx` (
  `id`		int(15)		not null auto_increment comment '主键id',
  `zxbhdm`	char(15)	default null		comment '中心编号代码',
  `cjsj`	date		default null		comment '创建时间',
  `jxrxm`	varchar(50)	default null		comment '缴存人姓名',
  `jcrxb`	char(2)		default null		comment '缴存人性别 ',
  `jcrlxdh`	char(20)	default null		comment '缴存人联系电话',
  `jcrzjlx`	char(2)		default null		comment '缴存人证件类型',
  `jcrzjh`	char(18)	default null		comment '缴存人证件号',
  `jcrcsny`	char(8)		default null		comment '缴存人出生年月',
  `jcrhyzk`	char(2)		default null		comment '缴存人婚姻状况',
  `jcrzy`	char(2)		default null		comment '缴存人职业',
  `jcrzc`	char(2)		default null		comment '缴存人职称',
  `jcrzw`	char(2)		default null		comment '缴存人职务',
  `jcrxl`	char(2)		default null		comment '缴存人学历',
  `grbnbje`	decimal(18,2)	default null		comment '个人本年补缴额',
  `grbnhje`	decimal(18,2)	default null		comment '个人本年汇缴额',
  `grljhje`	decimal(18,2)	default null		comment '个人累计汇缴额',
  `grljbje`	decimal(18,2)	default null		comment '个人累计补缴额',
  `jcedwbf`	decimal(18,2)	default null		comment '缴存额单位部分',
  `grbntqe`	decimal(18,2)	default null		comment '个人本年提取额',
  `grbnzre`	decimal(18,2)	default null		comment '个人本年转入额',
  `jcegrbf`	decimal(18,2)	default null		comment '缴存额个人部分',
  `grjcjs`	decimal(18,2)	default null		comment '个人缴存基数',
  `grjcye`	decimal(18,2)	default null		comment '个人缴存余额',
  `grkhrq`	date		default null		comment '个人开户日期',
  `grljjxe`	decimal(18,2)	default null		comment '个人累计结息额',
  `grljtqe`	decimal(18,2)	default null		comment '个人累计提取额',
  `grljzre`	decimal(18,2)	default null		comment '个人累计转入额',
  `grsnhje`	decimal(18,2)	default null		comment '个人上年汇缴额',
  `grsnbje`	decimal(18,2)	default null		comment '个人上年补缴额',
  `grsnjze`	decimal(18,2)	default null		comment '个人上年结转额',
  `grsntqe`	decimal(18,2)	default null		comment '个人上年提取额',
  `grsnzre`	decimal(18,2)	default null		comment '个人上年转入额',
  `grxhrq`	date		default null		comment '个人销户日期',
  `grxhyy`	char(2)		default null		comment '个人销户原因',
  `grzh`	char(50)	default null		comment '个人账号',
  `zrzhzt`	char(2)		default null		comment '个人账户状态',
  `yjce`	decimal(18,2)	default null		comment '月缴存额',
  `grhxkh`	char(20)	default null		comment '个人储蓄卡号',
  `djzt`	char(1)		default null		comment '冻结状态',
  primary key (`id`),
  unique key `idx_id` (`id`)
) engine=innodb default charset=gbk comment='个人基本信息';

/*
 * ===========================================================
 *   table：gjjjg_m_gj_grmx
 *   汉字名称: 个人明细信息
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_gj_grmx`;

create table `gjjjg_m_gj_grmx` (
  `id`		int(15)			not null auto_increment comment '主键id',
  `zxbhdm`	char(15)		default null		comment '中心编号代码',
  `cjsj`	date			default null		comment '创建时间',
  `jgh`		char(50)		default null		comment '机构号',
  `jyrq`	char(8)			default null		comment '交易日期',
  `zhlx`	char(6)			default null		comment '账户类型',
  `grzh`	char(50)		default null		comment '个人账号',
  `zgxm`	varchar(50)		default null		comment '职工姓名',
  `ywlx`	char(6)			default null		comment '业务类型',
  `pzh`		char(50)		default null		comment '凭证号',
  `dwzh`	char(50)		default null		comment '单位公积金账号',
  `cnlsh`	char(50)		default null		comment '出纳流水号',		
  `yh`		char(10)		default null		comment '开户银行',
  `fse`		decimal(18,2)		default null		comment '发生额',
  `zhye`	decimal(18,2)		default null		comment '账户余额',
  `sfcz`	char(20)		default null		comment '是否冲账',
  `rzry`	char(10)		default null		comment '入账人员',
  `rzrq`	char(8)			default null		comment '入账日期',
  `grjcbl`	decimal(18,2)		default null		comment '个人缴存比例',
  `dwjcbl`	decimal(18,2)		default null		comment '单位缴存比例',
  `tqyydm`	char(2)			default null		comment '提取原因代码',
  `tqyy`	varchar(50)		default null		comment '提取原因',
  `grfse`	decimal(18,2)		default null		comment '个人发生额',	
  `dwfse`	decimal(18,2)		default null		comment '单位发生额',	
  `zje`		decimal(18,2)		default null		comment '增加额',
  `jse`		decimal(18,2)		default null		comment '减少额',
  `ye`		decimal(18,2)		default null		comment '余额',	
  `snjzye`	decimal(18,2)		default null		comment '上年结转余额',
  `qnjzye`	decimal(18,2)		default null		comment '前年结转余额',
  `fslx`	decimal(18,2)		default null		comment '发生利息',
  `lsh`		char(50)		default null		comment '流水号',
  `czsj`	date			default null		comment '操作时间',
  `zh`		varchar(60)		default null		comment '个人储蓄帐户',
  `cxlx`	varchar(16)		default null		comment '储蓄类型',
  `yhhm`	varchar(30)		default null		comment '银行户名',
  `zqfs`	varchar(100)		default null		comment '支取方式',
  `zrzxqc`	varchar(60)		default null		comment '转入管理中心全称',
  `zrzxkhyh`	varchar(100)		default null		comment '转入管理中心开户银行',
  `zrzxzh`	varchar(100)		default null		comment '转入管理中心账号',
  `zrdwdjh`	varchar(16)		default null		comment '转入单位登记号',
  `zrsfzh`	varchar(30)		default null		comment '转入个人公积金帐号',
  `zcdwdjh`	varchar(16)		default null		comment '转出单位登记号',
  `zcsfzh`	varchar(30)		default null		comment '转出个人公积金帐号',
  `bfzqhq`	decimal(18,2)		default null		comment '部分支取活期',
  `bfzqdq`	decimal(18,2)		default null		comment '部分支取定期',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_cnlsh` (`cnlsh`),
  key `idx_dwzh` (`dwzh`),
  key `idx_grzh` (`grzh`)
) engine=innodb default charset=gbk comment='个人明细表（包括提取、缴存业务明细）';

/*
 * ===========================================================
 *   table：gjjjg_m_gj_ndjx
 *   汉字名称: 年度结息
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_gj_ndjx`;

create table `gjjjg_m_gj_ndjx` (
  `id`		int(15)			not null auto_increment comment '主键id',
  `zxbhdm`	char(15)		default null		comment '中心编号代码',
  `cjsj`	date			default null		comment '创建时间',
  `jgh`		char(50)		default null		comment	'机构号',
  `jznd`	char(4)			default null		comment '结转年度',
  `dwzh`	char(50)		default null		comment '单位账号',
  `grzh`	char(50)		default null		comment '个人账号',
  `snye`	decimal(18,2)		default null		comment	'上年余额',
  `snjs`	decimal(18,2)		default null		comment	'上年积数',
  `snlx`	decimal(18,2)		default null		comment	'上年利息',
  `snll`	decimal(18,2)		default null		comment	'上年利率',
  `bnye`	decimal(18,2)		default null		comment	'本年余额',
  `bnjs`	decimal(18,2)		default null		comment	'本年积数',
  `bnlx`	decimal(18,2)		default null		comment	'本年利息',
  `bnll`	decimal(18,2)		default null		comment	'本年利率',
  `bjze`	decimal(18,2)		default null		comment	'本金总额',
  `lxze`	decimal(18,2)		default null		comment	'利息总额',
  `jzye`	decimal(18,2)		default null		comment	'结转余额',
  `jzrq`	char(8)			default null		comment '结转日期',
  `czry`	char(20)		default null		comment '操作人员',
  `ljjc`	decimal(18,2)		default null		comment	'累计缴存',
  `lnjc`	decimal(18,2)		default null		comment	'历年缴存',
  `dnjc`	decimal(18,2)		default null		comment	'当年缴存',
  `ljzq`	decimal(18,2)		default null		comment	'累计支取',
  `lnzq`	decimal(18,2)		default null		comment	'历年支取',
  `dnzq`	decimal(18,2)		default null		comment	'当年支取',
  `ygz`		decimal(18,2)		default null		comment	'月工资',
  `yjc`		decimal(18,2)		default null		comment	'月缴存',
  `grzt`	char(6)			default null		comment '个人状态',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`)
) engine=innodb default charset=gbk comment='年度结息表';

/*
 * ===========================================================
 *   table：gjjjg_m_js_cnls
 *   汉字名称: 出纳流水
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_js_cnls`;

create table `gjjjg_m_js_cnls` (
  `id`		int(15)			not null auto_increment comment '主键id',
  `zxbhdm`	char(15)		default null		comment '中心编号代码',
  `cjsj`	date			default null		comment '创建时间',
  `jgh`		char(50)		default null		comment	'机构号',
  `ny`		char(8)			default null		comment '年月',
  `lsh`		char(50)		default null		comment	'出纳流水号',
  `zhdm`	char(10)		default null		comment '专户代码',
  `je`		decimal(18,2)		default null		comment	'金额',
  `jdfx`	char(2)			default null		comment '借贷方向',
  `pjh`		char(50)		default null		comment	'票据号',
  `zy`		char(50)		default null		comment '摘要',
  `rzsj`	char(8)			default null		comment '入账时间',
  `czsj`	char(8)			default null		comment '操作时间',
  `czy`		char(20)		default null		comment '操作员',
  `kjpzny`	char(8)			default null		comment '凭证所属年月',
  `sfcz`	char(50)		default null		comment	'是否冲账',
  `lx`		char(2)			default null		comment '业务类型',
  `cnzt`	char(2)			default null		comment '出纳状态',
  `rzzt`	char(2)			default null		comment '入账状态',
  `pzh`		char(50)		default null		comment	'凭证号',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_lsh` (`lsh`),
  key `idx_pzh` (`pzh`)
) engine=innodb default charset=gbk comment='出纳流水表';

/*
 * ===========================================================
 *   table：gjjjg_m_js_jsjyls
 *   汉字名称: 出纳流水
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_js_jsjyls`;

create table `gjjjg_m_js_jsjyls` (
  `id`		int(15)			not null		comment '主键id',
  `zxbhdm`	char(15)		default null		comment '中心编号代码',
  `cjsj`	date			default null		comment '创建时间',
  `ywlsh`	char(50)		default null		comment	'业务流水号',
  `ywfsrq`	char(8)			default null		comment '业务发生日期',
  `ywlx`	char(2)			default null		comment '业务类型',
  `ywpzlx`	varchar(32)		default null		comment '业务凭证类型',
  `ywpzhm`	varchar(32)		default null		comment '业务凭证号码',
  `ywzy`	varchar(60)		default null		comment '业务摘要',
  `jslsh`	char(50)		default null		comment	'结算流水号',
  `jsje`	decimal(18,2)		default null		comment '结算金额',
  `jsrq`	char(8)			default null		comment '结算日期',
  `jsyhdm`	char(3)			default null		comment '结算银行代码',
  `fkyhdm`	char(12)		default null		comment '付款银行代码',
  `fkwzh`	varchar(34)		default null		comment '付款人账户',
  `fkrhm`	varchar(60)		default null		comment '付款人户名',
  `fkrdz`	varchar(80)		default null		comment '付款人地址',
  `fkzhxz`	char(1)			default null		comment '付款账户性质',
  `skyhdm`	char(12)		default null		comment '收款银行代码',
  `skwzh`	varchar(34)		default null		comment '收款人账户',
  `skrhm`	varchar(60)		default null		comment '收款人户名',
  `skrdz`	varchar(80)		default null		comment '收款人地址',
  `skzhxz`	char(1)			default null		comment '收款账户性质',
  `clzt`	char(2)			default null		comment '处理状态',
  `yhlsh`	char(50)		default null		comment	'银行流水号',
  `yhjyrq`	char(8)			default null		comment '银行交易日期',
  `yhfhxx`	varchar(60)		default null		comment '银行返回信息',
  `jgh`		char(50)		default null		comment '机构号',
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_jgh` (`jgh`),
  key `idx_jslsh` (`jslsh`)
) engine=innodb default charset=gbk comment='结算交易流水表';

/*
 * ===========================================================
 *   table：gjjjg_m_yh_zjzhye
 *   汉字名称: 共同贷款人信息表
 *   创建人：  吕冠铭
 *   创建日期：2012.01.09
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_tj_zjzhye`;

create table `gjjjg_m_tj_zjzhye` (
  `id`		int(11)			not null auto_increment comment '主键id',
  `zxbhdm`	char(15)		default null		comment '中心编号代码',
  `cjsj`	date			default null		comment '创建时间',
  `yh_dm`	char(2)			default null		comment '银行代码',
  `zhye`	decimal(18,2)		default '0.00'		comment '账户余额',
  `kmbm`	char(50)		default null		comment '科目编号',
  primary key (`id`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：gjjjg_m_yh_yhzjjyls
 *   汉字名称: 银行主机交易流水
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_yh_yhzjjyls`;

create table `gjjjg_m_yh_yhzjjyls` (
  `id`		int(15)			not null auto_increment comment '主键id',
  `zxbhdm`	char(15)		default null		comment '中心编号代码',
  `cjsj`	date			default null		comment '创建时间',
  `zjlsh`	char(50)		default null		comment '主机流水号',
  `jyrq`	char(8)			default null		comment '交易日期',
  `jyje`	decimal(18,2)		default null		comment '交易金额',
  `sfzh`	varchar(30)		default null		comment '收方账号',
  `sfmc`	varchar(200)		default null		comment '收方名称',
  `ffzh`	varchar(30)		default null		comment '付方账号',
  `ffmc`	varchar(200)		default null		comment '付方名称',
  `yhbhdm`	char(50)		default null,
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbhdm` (`zxbhdm`),
  key `idx_zjlsh` (`zjlsh`)
) engine=innodb default charset=gbk comment='银行主机交易流水表';

/*
 * ===========================================================
 *   table：gjjjg_m_yh_yhzjywpt
 *   汉字名称: 银行主机业务平台
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `gjjjg_m_yh_yhzjywpt`;

create table `gjjjg_m_yh_yhzjywpt` (
  `id`		int(15)			not null auto_increment		comment '主键id',         
  `zxbhdm`	char(15)		default null			comment '中心编号代码',   
  `cjsj`	date			default null			comment '创建时间',       
  `zxbh`	char(50)		default null			comment '中心编号',       
  `zxlsh`	char(50)		default null			comment '中心流水号',     
  `yhlsh`	char(50)		default null			comment '银行流水号',     
  `zjlsh`	char(50)		default null			comment '主机流水号',     
  `jkhth`	char(50)		default null			comment '借款合同号',     
  `zxzh`	char(50)		default null			comment '中心账号',       
  `zxkhhm`	varchar(100)		default null			comment '中心客户名称',   
  `khmc`	varchar(50)		default null			comment '银行客户名称',   
  `khzh`	char(30)		default null			comment '银行客户账号',   
  `je`		decimal(18,2)		default null			comment '金额',           
  `bj`		decimal(18,2)		default null			comment '本金',           
  `lx`		decimal(18,2)		default null			comment '利息',           
  `fx`		decimal(18,2)		default null			comment '罚息',           
  `jyrq`	char(8)			default null			comment '交易日期',       
  `ywlx`	char(2)			default null			comment '业务类型',       
  `yhbh_dm`	char(50)		default null			comment '银行编号代码',   
  `pzh`		char(50)		default null			comment '凭证号',         
  primary key (`id`),
  unique key `idx_id` (`id`),
  key `idx_zxbh_dm` (`zxbhdm`),
  key `idx_ywlx` (`ywlx`),
  key `idx_zxbh` (`zxbh`),
  key `idx_zxzh` (`zxzh`),
  key `idx_zxlsh` (`zxlsh`),
  key `idx_pzh` (`pzh`)
) engine=innodb default charset=gbk comment='银行中间业务平台表';

/*
 * ===========================================================
 *   table：log_crawlcloud
 *   汉字名称:云平台抓数日志
 *   创建人：  杨冠
 *   创建日期：2011.10.28
 *   修改人：陈世刚
 *   修改日期：2011.12.26
 *   修改内容：调整表结构
 * ===========================================================
 */

drop table if exists `log_crawlcloud`;

create table `log_crawlcloud` (
  `id`		int(15)			not null auto_increment comment '主键,自增长',
  `sql_id`	varchar(200)		default	null		comment '当前操作的sql_id',
  `content`	varchar(500)		default null		comment '操作内容说明',
  `createtime`	char(50)		default null		comment '入库时间,精确到毫秒',
  `pageno`	int(15)			default null		comment '当前操作的sql_id对应的数据入库的页号',
  `datacount`	 int(50)		default null		comment '本页的数据条数',
  primary key (`id`)
) engine=innodb auto_increment=5 default charset=gbk;

/*
 * ===========================================================
 *   table：log_scan
 *   汉字名称: 扫描日志表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `log_scan`;

create table `log_scan` (
  `id`			int(11)			not null auto_increment comment '主键id',
  `zxbhdm`		char(15)		not null		comment '中心编号代码',
  `ywlx`		char(15)		not null		comment '业务类型',
  `scanlx`		char(200)		not null		comment '扫描算法类型',
  `createdate`		char(50)		not null		comment '创建时间,精确到秒',
  `datanum`		int(10)			not null		comment '数据变化量',
  `code`		char(50)		default null		comment '编号',
  `bz`			varchar(500)		default null		comment '备注',
  `operator`		char(20)		default null		comment '操作类型',
  `operatordate`	char(30)		default null		comment '操作时间',
  `tablename`		char(50)		default null		comment '操作数据库表',
  primary key (`id`),
  unique key `index_id` (`id`)
) engine=innodb default charset=gbk;

/*
 * ===========================================================
 *   table：scan_job
 *   汉字名称: 扫描任务表
 *   创建人：  杨冠
 *   创建日期：2011.12.26
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */

drop table if exists `scan_job`;
create table `scan_job` (
  `id`		int(11)		not null auto_increment comment '主键id',
  `zxbhdm`	char(15)	not null		comment '中心编号代码',
  `ywlx`	char(15)	not null		comment '业务类型',
  `scan`	char(20)	not null		comment '扫描算法类型',
  `yxbj`	char(1)		not null		comment '有效标记:1,使用;0,未使用',
  primary key (`id`)
) engine=innodb auto_increment=10 default charset=gbk;

/*
 * ===========================================================
 *   table：datadistribute_route
 *   汉字名称:数据分发路由表
 *   创建人：  庞艳蕊
 *   创建日期：2011.10.18
 *   修改人：陈世刚
 *   修改日期：2011.12.26
 *   修改内容：调整表结构
 * ===========================================================
 */
drop table if exists `datadistribute_route`;
create table `datadistribute_route` (
  `id`		int(15)		not null auto_increment		comment 'id',
  `zxbhdm`	char(15)	not null			comment '中心编号代码',
  `zxbhmc`	char(100)	not null			comment '中心名称',
  `ip`		char(50)	not null			comment '地址',
  `port`	char(50)	not null			comment '端口',
  `url`		char(50)	not null			comment 'url',
  `username`	char(50)	        			comment '用户名',
  `password`	char(50)	        			comment '密码',
  `methodname`	char(50)	        			comment '方法名',
  `type`	char(2)		not null			comment '类型',
  `yxbz`	char(1)		not null			comment '有效标志',
  primary key (`id`)
) engine=innodb default charset=gbk;
/*
 * ===========================================================
 *   table：`datadistribute_type`
 *   汉字名称:数据分发方式
 *   创建人：  陈世刚
 *   创建日期：2012.06.11
 *   修改人：
 *   修改日期：
 *   修改内容：
 * ===========================================================
 */
drop table if exists `datadistribute_type`;
create table `datadistribute_type` (
  `typeid`		char(2)		not null 		comment 'id',
  `typename`		char(30)				comment 'ip地址',
  primary key (`typeid`)
) engine=innodb default charset=gbk;
insert into `datadistribute_type` values('01','WEBSERVICE');

/*
 * ===========================================================
 *   table：datatrans_log
 *   汉字名称:数据服务平台日志
 *   创建人：  庞艳蕊
 *   创建日期：2011.10.18
 *   修改人：陈世刚
 *   修改日期：2011.12.26
 *   修改内容：调整表结构
 * ===========================================================
 */
drop table if exists `datatrans_log`;
create table `datatrans_log` (
  `id`		int(15)		not null auto_increment		comment 'id',
  `ip`		char(30)					comment 'ip地址',
  `datetime`	char(50)	not null			comment '时间',
  `level`	char(10)	not null			comment '级别',
  `classname`	char(100)	not null			comment '日志输出类',
  `threadname`	char(50)					comment '线程',
  `methodname`	char(50)					comment '方法名称',
  `line`	char(100)					comment '行数',
  `message`	varchar(2000)	        			comment '日志信息',
  primary key (`id`)
) engine=innodb default charset=gbk;