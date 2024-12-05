DROP TABLE T_MENU;

CREATE TABLE T_MENU
(
  SEQ  NUMBER NOT NULL,
  DEPTH1    VARCHAR2(40 BYTE),
  DEPTH2    VARCHAR2(40 BYTE),
  DEPTH3    VARCHAR2(40 BYTE),
  URL    VARCHAR2(30 BYTE)
);

COMMENT ON TABLE T_MENU IS '메뉴정보테이블';
COMMENT ON COLUMN T_MENU.SEQ IS '정산일자';
COMMENT ON COLUMN T_MENU.DEPTH1 IS '대매뉴';
COMMENT ON COLUMN T_MENU.DEPTH2 IS '중매뉴';
COMMENT ON COLUMN T_MENU.DEPTH3 IS '소매뉴';
COMMENT ON COLUMN T_MENU.URL IS 'URL';


INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (1,'경매정보','경매관리','공판장별 경매기록부','/haa01/haa01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (2,'경매정보','경매관리','공판장별 품목경락가격','/haa02/haa02.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (3,'경매정보','경매관리','공판장별 품종경락가격','/haa03/haa03.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (4,'경매정보','경매관리','공판장별 주요거래지표','/haa04/haa04.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (5,'경매정보','실적분석관리','실시간 경매조회','/real/real2.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (6,'경매정보','실적분석관리','일자별 경매분석','/hab01/hab01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (7,'경매정보','실적분석관리','월별 경매분석','/hab02/hab02.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (8,'경매정보','실적분석관리','경락단가내역','/hab03/hab03.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (9,'경매정보','실적분석관리','품목별 총 거래분석','/hab04/hab04.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (10,'경매정보','실적분석관리','품종별 총 거래분석','/hab05/hab05.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (11,'경매정보','실적분석관리','월별전년대비실적','/hab06/hab06.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (12,'경매정보','실적분석관리','지역별 월별 출하실적','/hab07/hab07.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (13,'생산정보','출하 및 작황정보','출하 및 예정물량','/hca01/hca01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (14,'생산정보','출하 및 작황정보','재배동향','/hca02/hca02.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (15,'생산정보','출하 및 작황정보','작황정보','/hca03/hca03.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (16,'소비정보','소비동향(장미)','소비동향','/auction/SalePrice.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (17,'소비정보','소매가격(장미)','소매가격동향','/hdb01/hdb01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (18,'유통정보','거래동향보고서','순별장미수급예측보고서','/hba01/hba04.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (19,'유통정보','거래동향보고서','월간장미수급예측보고서','/hba01/hba01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (20,'유통정보','거래동향보고서','월간거래동향보고서','/hba02/hba02.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (21,'유통정보','거래동향보고서','화훼유사시장보고서','/hba03/hba03.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (22,'열린광장','열린마당','공지사항','/hfa01/hfa01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (23,'열린광장','열린마당','행사안내','/hfc01/hfc01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (24,'모니터요원','생산정보입력','출하예정물량 입력','/maa01/maa01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (25,'모니터요원','생산정보입력','출하물량 입력','/maa01/maa01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (26,'모니터요원','생산정보입력','작황동향 입력','/mab02/mab02.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (27,'모니터요원','생산정보입력','재배동향 입력','/mac01/mac01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (28,'모니터요원','소비정보 입력','소비동향 입력','/mba01/mba01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (29,'모니터요원','소비정보 입력','소매가격 입력','/mbb01/mbb01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (30,'모니터요원','정산정보 관리','계량/비계량 설정','/mda01/mda01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (31,'모니터요원','정산정보 관리','모니터요원 관리','/mdb01/mdb01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (32,'모니터요원','정산정보 관리','정산내역','/mdc01/mdc01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (33,'모니터요원','정산정보 관리','발송이력 관리','/mdc01/mdd01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (34,'모니터요원','게시판관리','순별장미수급예측보고서','/mcc02/mcc02.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (35,'모니터요원','게시판관리','월간장미수급예측보고서','/mca01/mca01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (36,'모니터요원','게시판관리','월간동향보고서','/mcb01/mcb01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (37,'모니터요원','게시판관리','화훼유사시장보고서','/mcc01/mcc01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (38,'모니터요원','게시판관리','공지사항','/mcd01/mcd01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (39,'모니터요원','게시판관리','행사일정 관리','/mce01/mce01.do');
INSERT INTO T_MENU (SEQ, DEPTH1, DEPTH2, DEPTH3, URL) VALUES (40,'모니터요원','매뉴얼','매뉴얼','/cmmn/manual.do');
