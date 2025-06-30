use GUILD;
-- 시간값은 서버에서 받아오는 기준으로 한다.
create table guild_info(
	guild_idx bigint IDENTITY (10000001, 1) NOT NULL Primary key,		-- 길드 고유값, 10000001부터 시작, 길드 첫 생성시 해당값 발급
	guild_name nvarchar(20) NOT NULL UNIQUE,							-- 길드명
	guild_master_name nvarchar(20) not null,							-- 길드장 이름
	guild_master_idx bigint not null,									-- 길드장 고유값
	[level] int not null default 1,										-- 길드 레벨
	[exp] int not null default 0,										-- 길드 경험치
	guild_points int not null default 0,								-- 길드 포인트
	guild_status tinyint NOT NULL default 0,							-- 길드 상태값 ( 0- 모집중, 1-정지 ..)
	comment nvarchar(300),												-- 길드 소개란.
	member_cnt int not null default 1,									-- 길드원 수
	icon int not null default 0,										-- 길드 아이콘
	created_date DATETIME not null default getdate(),					-- 길드 생성 시간
	updated_date datetime not null default getdate()					-- 길드 정보 변경 시간
);

create table guild_member(
	guild_idx bigint not null,											-- 길드 고유값
	user_idx bigint not null,											-- 길드원 고유 값
	[user_name] nvarchar(20) not null,									-- 길드원 이름
	member_grade int not null default 0,								-- 길드원 등급 (0-길드원, 1-관리자, 2-길드장)
	contribution_point int not null,									-- 기여도
	created_date datetime not null default getdate(),					-- 가입일
	last_login_date datetime ,											-- 마지막 접속 시간
	update_date datetime not null default getdate(),					-- 길드원 정보 변경시간
	CONSTRAINT pk_guild_member primary key (guild_idx, user_idx)	
);

create table guild_join_request(
	seq_key bigint not null IDENTITY (1, 1) Primary key,				-- seq_key
	guild_idx bigint not null,											-- 신청한 길드id					--인덱스
	user_idx bigint not null,											-- 신청한 유저idx				--인덱스
	[status] tinyint not null,											-- 0-신청중, 1-거절, 2-승인
	created_date datetime not null default getdate(),					-- 신청 시간
	updated_date datetime not null default getdate()					-- 처리 시간
)
CREATE INDEX IX_request_gidx ON guild_join_request (guild_idx);
CREATE INDEX IX_request_uidx ON guild_join_request (user_idx);
CREATE UNIQUE INDEX IX_request_guidx ON guild_join_request (guild_idx,user_idx);
