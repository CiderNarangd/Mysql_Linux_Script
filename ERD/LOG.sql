use [LOG]
-- Ȯ�强 ����Ͽ� �߰��÷� �̸� �����س������� ����
-- ������ ���̺� �ۼ� or ��Ƽ�Ŵ��Ͽ� ����
create table login_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,
	user_idx bigint not null,
	login_date datetime not null,										-- �α��� �ð�
	last_login_date datetime not null,									-- ���� �α��� �ð�
	[login_type] tinyint not null,										-- 0 - Google, 1 - Apple Login, 2 - MS, 3 - ���̹�.... , 99-�Խ�Ʈ
	os_version nvarchar(50)	not null default'zz',						-- os ����
	device_name nvarchar(50) not null default 'zz',						-- ����
	country_code char(3) not null default 'zz',							-- �����ڵ�
	created_date datetime not null default getdate()					-- �α� ������
)

-- ������ ���������� �Ϸ�� �α׸� ���Եȴ�.
create table billing_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,
	user_idx bigint not null,											-- ���� ������
	login_date datetime not null,										-- �α��� �ð�
	os_version nvarchar(50)	not null default'zz',						-- OS��
	device_name nvarchar(50) not null default 'zz',						-- ����
	market_type tinyint not null,										-- 0 - Google, 1 - AppStore ....
	product_id int not null,											-- ��ǰid
	amount decimal(10,2) not null,										-- ���Ű���
	currency nvarchar(5) not null default 'zz',							-- ��ȭ
	bill_start_date datetime not null,									-- ���� ���� �ð�
	bill_end_date datetime not null,									-- ���� �Ϸ� �ð�
	created_date datetime not null default getdate()					-- �α� ���� �ð�
)

create table quest_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,				
	user_idx bigint not null,											-- ���� ������
	login_date datetime not null,										-- �α��� �ð�
 	quest_id int not null,												-- ����Ʈid
	completed_date  datetime not null,									-- �Ϸ�ð�
	created_date datetime not null,										-- �α� ���� �ð�
)
create table match_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,				
	season_idx int not null,											-- ���� �ε���
	user1_idx bigint not null,											-- ����1 ������
	user2_idx bigint not null,											-- ����2 ������
	user1_score int not null											-- ����1 ���� ����
	user2_score int not null											-- ����2 ���� ����
	user1_before_score int not null										-- ����1 ��� ���� ����
	user1_before_score int not null										-- ����2 ��� ���� ����
	user1_after_score int not null										-- ����1 ��� ���� ����
	user1_after_score int not null										-- ����2 ��� ���� ����
	user1_info nvarchar(300) not null,									-- ����1 ���, ��ų ����
	user2_info nvarchar(300) not null,									-- ����2 ���, ��ų ����
	match_time int not null,											-- ���� �ð�
	mastch_start_date datetime not null,								-- ���� ���� �ð�
	match_end_date datetime not null,									-- ���� ���� �ð�
	created_date datetime not null default getdate()					-- �α� ���� �ð�
)

create table item_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,					
	user_idx bigint not null,											-- ���� ���� ��
	event_type tinyint not null,										-- ȹ��/��� ��� ( ����, ������, ���, ....  )
	item_id int not null,												-- ������id
	item_cate tinyint not null,											-- ������ ī�װ� ( ���, �Ҹ�ǰ ....)
	quantity_change int not null,										-- ���/ȹ�� ����
	before_quantity int not null,										-- ȹ��/��� �� ���� ����  (������� 0���� ó��)
	after_quantity int not null,										-- ȹ��/��� �� ���� ����  (������� 0���� ó��,)
	option1_id int not null,											-- �ɼ�1 id
	option1_value int not null,											-- �ɼ�1 value							
	option2_id int not null ,											-- �ɼ�2 id
	option2_value int not null,											-- �ɼ�2 value
	option3_id int not null,											-- �ɼ�3 id
	option3_value int not null,											-- �ɼ�3 value
	option4_id int not null,											-- �ɼ�4 id
	option4_value int not null,											-- �ɼ�4 value
	option5_id int not null,											-- �ɼ�5 id
	option5_value int not null,											-- �ɼ�5 value
	changed_date datetime not null,										-- ���/ȹ�� �ð�
	created_date datetime not null default getdate()					-- �α� ���� �ð�
)

create table goods_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,					
	user_idx bigint not null,											-- ���� ���� ��
	event_type tinyint not null,										-- ȹ��/��� ��� ( ����, ������, ���, ....  )
	product_id int not null,											-- ��ȭ ������� ȹ���� ������ id
	product_quantity int not null,										-- ȹ���� ������ ����
	free_goods_change int not null,										-- ���� ��ȭ ��ȭ��		
	paid_goods_change int not null,										-- ���� ��ȭ ��ȭ��
	before_free_goods int not null,										-- ���� ��ȭ ������ 
	before_paid_goods int not null,										-- ���� ��ȭ ������
	after_free_goods int not null,										-- ���� ��ȭ ������
	after_paid_goods int not null,										-- ���� ��ȭ ������
	changed_date datetime not null,										-- �̺�Ʈ �߻� �ð�
	created_date datetime not null default getdate()				    -- �α� ���� �ð�
)

create table guild_request_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,	
	user_idx bigint not null,											-- ���� ������
	guild_idx bigint not null,											-- ��� ������
	guild_master_idx bigint not null,									-- ����� ������
	action_type tinyint not null,										-- 0-��û, 1-��û����, 2-��û����, 3-�߹�, 4-Ż��
	event_date datetime not null,										-- �̺�Ʈ �߻� �ð�
	created_date datetime not null default getdate()					-- �α� ���� �ð�

)

create table freind_event_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,	
	user_idx bigint not null,											-- ���� ������	
	friend_idx bigint not null,											-- ��û���� ģ�� ������
	action_type tinyint not null,										-- 0-��û, 1-����, 2-��û����, 3-ģ������
	event_date datetime not null,										-- �̺�Ʈ �߻� �ð�
	created_date datetime not null default getdate(),					-- �α� ���� �ð�
	
)

create table mail_log(
	seq_key bigint IDENTITY (1, 1) not null primary key,	
	user_idx bigint not null,											-- ���� ������	
	title nvarchar(50) not null default '',								-- ���� ����
	contents nvarchar(300) not null default '',							-- ���� ����
	received_date datetime not null,									-- ���� ���� �ð�
	read_date datetime not null,										-- ���� ���� �ð�
	sender_idx bigint not null,											-- �߽���
	item_id	int not null,												-- ������ ������id (������ 0)
	item_cnt int not null,												-- ������ ���� 
	created_date datetime not null default getdate(),					-- �α� ���� �ð�
)

