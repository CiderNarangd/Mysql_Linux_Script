use GAME;
--�ð����� �⺻������ �������� �޾ƿ��°��� ��Ģ���� �Ѵ�.
create table user_game_info(
	user_idx bigint not null primary key,								-- ���� ������
	[user_name] nvarchar(20) not null unique,							-- ���� �̸�
	[level] int not null default 1,										-- ���� ����
	[exp] int not null default 0,										-- ����ġ
	free_goods int not null default 0,									-- ���� ��ȭ
	paid_goods int not null default 0,									-- ���� ��ȭ
	skill_points int not null default 0,								-- ��ų ����Ʈ
	score int not null,													-- ����
	created_date datetime not null default getdate(),					-- �ش� ���̺� ���� �ð�
	updated_date datetime not null default getdate()					-- ���� ���� ������ ���� �ð�
);

-- user_idx pk������ ������ ���ø��� ���Ұ����� ����Ǿ�, ��üŰ ���
-- user_idx �������� �ε��� �����ؼ� ���.
-- �κ��丮 ���̺��� �������� �������� �÷��̾�� ĳ���Ͱ� �þ�� ĳ���ͺ� �κ��丮�� ���ԵǸ� ������ �þ��.
-- ���� �����Ͽ� �ο�� ���̴°͵� ��� �ʿ�.( )
create table equip_inven(		
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null,											-- ���� ������
	item_type int not null,												-- ����	
	item_id int not null,												-- ������id
	option1_id int not null default 0,									-- ������ �ɼ� id
	option1_value int not null default 0,								-- ������ �ɼ� value
	option2_id int not null default 0,
	option2_value int not null default 0,
	option3_id int not null default 0,
	option3_value int not null default 0,
	is_equipped tinyint not null default 0,								-- ���� ���� // ����x-0, ����o -1
	item_expiration_date datetime not null default '2050-01-01',		-- ������ ������
	updated_date datetime not null,										-- ������ ���� ������
	created_date datetime not null default getdate(),					-- ������ ȹ����
);


-- ���� ���� ������ ���������� �����̸� �÷��� �÷��� ROW�� ���̴� ����̰�����, 
-- �������� �����Ƿ� ROW�� �ø��� �������
-- ĳ���� ���� ������ �ʱⰪ���� �����Ͽ� �ο츦 �־��ش�.
create table equip_item(
	user_idx bigint not null,											-- 
	slot_type int not null,												-- 0-����, 1-�Ӹ�, 2-����, 3-�ٸ�, 4-�� .... 
	inven_index	bigint not null default 0,								-- �κ��丮�� �մ� seq_key��, 0�̸� ����x����
	equipped_time datetime not null default getdate()					-- ������ ���� �ð�.
)

-- �������� ����Ͽ� �κ��丮 ���̺� �и�.
-- �����ϰ� ������ ���� ������ ���� ����ʿ�.
create table consumable_inven(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null,											-- ���� ������
	item_type int not null,												-- ��� / ���� .. 
	item_id int not null,												-- ������id					
	quantity int not null,												-- ����
	item_expiration_date datetime not null default '2050-01-01',		-- ������ ������
	updated_date datetime not null,										-- ������ ���� ������
	created_date datetime not null default getdate(),					-- ������ ȹ����
)

create table Mail(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null,											-- ���� ������
	title nvarchar(50) not null default '',								-- ���� ����
	contents nvarchar(300) not null default '',							-- ���� ����
	is_read tinyint not null default 0,									-- ���� ����
	item_type int not null default 0,									-- �������� ÷�εǾ�������, ������ 0
	item_id int not null default 0,										-- �������� ÷�εǾ�������, ������ 0
	sented_time datetime not null default getdate(),					-- ���� �ð�
	expired_date datetime not null default '2050-01-01'					-- ������
)

create table user_quest(
	user_idx bigint not null ,											-- ���� ���� ��
	quest_id int not null,												-- ����Ʈ id
	quest_status int not null default 0,								-- ����Ʈ ���� 0-����Ʈ ���� ����. 1-����Ʈ ������ , 2-����Ʈ �Ϸ�
	quest_progress int not null default 0,								-- ����Ʈ ���� ����
	created_date datetime not null default getdate(),					-- ����Ʈ ���� ���� �ð�
	updated_date datetime not null default getdate(),					-- ����Ʈ ���� ���� �ð�
)

create table user_achievement(
	user_idx bigint not null primary key ,								-- ���� ���� ��
	achievement_cate int not null,										-- ���� ī�װ�
	achievement_id int not null,										-- ���� id
	achievement_progress int not null,									-- ���� �������
	achievement_goal int not null,										-- ���� �޼��ʿ䰪
	achievement_status int not null,									-- ���� ����		0-�̴޼�, 1-�޼�
	created_date datetime not null default getdate(),					-- ���� �޼���
	updated_date datetime not null default getdate()					-- ���� ���� ������
)

create table user_skill(
	user_idx bigint not null primary key,								-- ���� ���� ��
	skill_id int not null,												-- ��ų id
	skill_level int not null,											-- ��ų level	
	created_date datetime not null default getdate()					-- ��ų ȹ����
)

create table friend(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null, 
	friend_idx bigint not null,
	created_date datetime not null default getdate()					-- ģ�� ������
)

create table friend_request(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null,											-- ��û ���� ���� ���� ��
	request_user_idx bigint not null,									-- ��û ���� ���� ���� ��
	[status] tinyint not null default 0,								-- 0-��û��, 1-����, 2-���� 
	created_date datetime not null default getdate(),					-- ��û �ð�
	responed_date datetime not null,									-- ���� �ð�
)
--��û�ϱ������� 


-- ������ �Ŵ������� ������ �������� text�� ������ �ʿ�.
-- ������ �ִ� 10�������� �����Ѵٰ� ���� / ��� ��ġ��ϵ��� LogDB�� ����.
-- �������ǻ� �ѹ��� ��ġ�� �ΰ��� �ο찡 Insert.
create table match_history
(
	seq_key bigint IDENTITY (1, 1) not null primary key,				-- ��ü Ű
	user_idx bigint not null,											-- ���� ���� ��
	opponent_user_idx bigint not null,									-- ��� ���� ���� ��
	result tinyint not null,											-- ���
	score int not null,													-- ȹ�� ����
	opponent_score int not null,										-- ����� ȹ�� ����
	user_info_list	nvarchar(300) not null,								-- ���� ����� ��ų, ������ ����Ʈ
	opponent_info_list nvarchar(300) not null,							-- ������� ����� ��ų, ������ ����Ʈ
	match_time int not null,											-- ���� �ð�
	match_start_date datetime not null,									-- ��ġ ���� �ð�
	match_end_date datetime not null									-- ��ġ ���� �ð�
)

-- �ΰ��ӿ��� �������� ���� n�� ���̺�
-- �ϴ����� ������ �ֽ�ȭ (�Ʒ� leader_board ���̺��� ������ó�� �� �ش� ���̺� insert)
-- �ǽð� ��ŷ�ʿ��ϸ� ���� ��� ��� �ʿ�
create table daily_ranking(
	[rank] int IDENTITY (1, 1) not null primary key,					-- ����
	user_idx bigint not null,											-- ���� ������
	[user_name] nvarchar(20) not null,									-- �����̸�	
	score	int not null,												-- ����
)

-- ���� ������ ���� �������� �������� ���� �����ϴ� ��������
-- ��ī�̺� ó�� �ʿ��Ҽ���
create table leader_board(
	season_idx int not null,											-- �����ε���
	user_idx bigint not null,											-- ���� ������
	score int not null,													-- �ش� ���� ����
	created_date datetime not null,										-- ���� ������
	updated_date datetime not null,										-- ���� ������
	CONSTRAINT pk_season_useridx primary key (season_idx, user_idx)	
)
