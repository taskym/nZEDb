DROP TABLE IF EXISTS relsearch;
CREATE TABLE relsearch (
        id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
        releaseid INT(11) UNSIGNED NOT NULL,
        name VARCHAR(255) NOT NULL DEFAULT '',
        searchname VARCHAR(255) NOT NULL DEFAULT '',
        categoryid INT(11) NOT NULL DEFAULT 7010,
        PRIMARY KEY (id)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

CREATE FULLTEXT INDEX ix_relsearch_searchname_name_ft ON relsearch (searchname, name);
CREATE UNIQUE INDEX ix_relsearch_releaseid ON relsearch (releaseid);

INSERT INTO relsearch (releaseid, name, searchname, categoryid) (SELECT id, name, searchname, categoryid FROM releases);

DELIMITER $$
CREATE TRIGGER insert_search AFTER INSERT ON releases FOR EACH ROW
BEGIN
        INSERT INTO relsearch (releaseid, name, searchname, categoryid)
        VALUES (NEW.id, NEW.name, NEW.searchname, NEW.categoryid);
END;
$$
CREATE TRIGGER update_search AFTER UPDATE ON releases FOR EACH ROW
BEGIN
        IF NEW.name != OLD.name
        THEN UPDATE relsearch SET name = NEW.name WHERE releaseid = OLD.id;
        END IF;
        IF NEW.searchname != OLD.searchname
        THEN UPDATE relsearch SET searchname = NEW.searchname WHERE releaseid = OLD.id;
        END IF;
        IF NEW.categoryid != OLD.categoryid
        THEN UPDATE relsearch SET categoryid = NEW.categoryid WHERE releaseid = OLD.id;
        END IF;
END;
$$
CREATE TRIGGER delete_search AFTER DELETE ON releases FOR EACH ROW
BEGIN
        DELETE FROM relsearch WHERE releaseid = OLD.id;
END;
$$
DELIMITER ;

UPDATE site set value = '185' where setting = 'sqlpatch';
