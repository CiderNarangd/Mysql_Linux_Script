use COMMON;
-- �ð����� �������� �޾ƿ��� �������� �Ѵ�.
-- ����� ���� �����ͺ��̽�
-- ����,���� ���� �� ���� ���� ����

-- ����� ���� ���̺� : ������ ���� ����
create table user_info(
	user_idx bigint IDENTITY (10000001, 1) NOT NULL Primary key,		-- ���� ������, 10000001���� ����, ���� ù ���Խ� �ش簪 �߱�
	[user_name] nvarchar(20) NOT NULL UNIQUE,							-- ���� �г���
	country_code char(3) NOT NULL DEFAULT 'zz',							-- �����ڵ� (default zz)
	device_name nvarchar(50) NOT NULL DEFAULT 'zz',						-- ������� ����
	os_version nvarchar(50) NOT NULL default 'zz',						-- ������� ����� os��
	last_login_date datetime NOT NULL default getdate(),				-- ������ �α��� �ð�
	user_status tinyint NOT NULL default 0,								-- User ���°� ( 0-�⺻, 1-����, 2-�޸� ... )
	is_guest tinyint NOT NULL default 0,								-- guest���� ( 0-guest, 1-�Ҽ� �α��� ���� )
	created_date DATETIME not null default getdate(),					-- ���� ���� �ð� ( )
	updated_date datetime not null default getdate()					-- ���� ���� ���� �ð�
);

-- �α��� ���� ���̺� : �Ҽ� �÷����� �α��� ���� ����
create table login_info
(
	user_idx bigint not null,											-- ���� ������
	platform_type tinyint not null,										-- �÷��� Ÿ�� (0 - Google, 1 - Apple Login, 2 - MS, 3 - ���̹�.... )
	access_token nvarchar(300) null,									-- �׼��� ��ū
	refresh_token nvarchar(300) null,									-- �������� ��ū
	created_date datetime not null default getdate(),					-- �÷��� ���� ���� ����
	updated_date datetime not null default getdate(),					-- �ش� �ο� ���� ����.
	CONSTRAINT pk_login_user_platform primary key (user_idx, platform_type)	
)

-- ������ ���� ���̺� : ���� ���� ���� �� �Ⱓ ����
create table block_user_list
(
	user_idx bigint not null primary key,								-- ���� ���� ��
	block_reason tinyint not null,										-- ���� ���� ( 0 - ��ų� ����, 1 - )
	block_detail_reason nvarchar(500) default null,						-- �� ����
	blocked_by nvarchar(30),											-- ���� ���� ( ���, System ... )
	is_active tinyint not null default 1,								-- ���� Ȱ�� ���� ( 0 - ���� ���� ��Ȱ��ȭ, 1- ���� ���� Ȱ��ȭ)
	block_start_date datetime not null default '2000-01-01',			-- ���� ���� �ð�
	block_end_date datetime not null default '2000-01-01',				-- ���� ������
	
)

-- ���� ���̺� : ���� ���� ���� ���̺� (�α� ���̺�� ����)
create table billing
(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null,											-- ���� ���� ��
	platform_type int not null,											-- ( 0 - Google Market, 1 - AppStore, 2 - OneStore....)
	[status] int not null,												-- ���� ���� (0 - ������, 1 - �Ϸ�, 2 - ���� ...)
	product_id int not null,											-- ��ǰID
	country_code char(3) NOT NULL DEFAULT 'zz',							-- �����ڵ� (default zz)
	amount decimal(10,2) not null,										-- �ݾ�
	currency nvarchar(5) not null default 'zz',							-- ȭ�� �ڵ�
	receipt nvarchar(300),												-- ������
	fail_reason nvarchar(300) default null,								-- ���� ���� ����
	bill_start_date datetime default getdate(),							-- ���� ���� �ð� 
	bill_updated_date datetime ,										-- ���� ���� ���� �ð�
	bill_end_date datetime												-- ���� �Ϸ� �ð�

)

-- ���� ���� ���̺�
create table Notice
(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű 
	notice_type int not null default 0,									-- ���� Ÿ�� (0 - �Ϲ� , 1 - ���...)
	contents text not null default '',									-- ����
	is_active tinyint not null default 0,								-- ���� �V��ȭ ����( 0 - ��Ȱ��ȭ, 1- Ȱ��ȭ)
	notice_start_date datetime not null default '2000-01-01',			-- ���� ������ 
	notice_end_date datetime not null default '2000-01-01',				-- ���� ������
)
