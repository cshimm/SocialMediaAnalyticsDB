DELIMITER //
CREATE PROCEDURE process_hashtag()
BEGIN

    DECLARE tag_hold VARCHAR(400);
    DECLARE tag1 VARCHAR(45);

    DECLARE data_feed_max INT;
    DECLARE index_val INT DEFAULT 1;
    DECLARE event_id_hold INT;
    DECLARE finished INTEGER DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    SELECT MAX(data_feed_id) INTO data_feed_max FROM SM_data_feed;

    WHILE index_val =< data_feed_max DO
        -- store hashtags
        SELECT event_id, hashtags INTO event_id_hold, tag_hold
        FROM SM_data_feed WHERE data_feed_id = index_val;

        DECLARE idx INT DEFAULT 1;
        -- this will return the number of delimiters in the string, we can assume  the delimiter is just a single comma for simplicity
        DECLARE max_idx INT DEFAULT 1 + (LENGTH(tag_hold) - LENGTH(REPLACE(tag_hold, ',', '')))

        WHILE idx <= max_idx DO
            -- pull the last hashtag from the string & update the string
            SET tag1 = TRIM(SUBSTRING_INDEX(tag_hold, ',', -1));
            SET tag_hold = SUBSTRING_INDEX(tag_hold, ',', (max_idx-idx))
            -- since max number is always constant and we're updating to pull a new string witout
            -- the last addition, it's gonna take the left side string of tag_hold

            -- the following call will create a new entry in the link table event_tag
            CALL UpsertHashtags(event_id, tag1);

            SET idx = idx + 1;
        END WHILE;

        SET index_val = index_val + 1;
    END WHILE;


END //
DELIMITER;




DELIMITER //
CREATE PROCEDURE UpsertHashtags(IN event_id INT, IN tag1 VARCHAR(45))

    DECLARE hashtag_id1 INT;
    DECLARE entry_exist INT;

    -- see if there is an existing hashtag
    SELECT COUNT(*) INTO entry_exist
    FROM hashtags WHERE hashtag_name = tag1

    IF entry_exist > 0 THEN
        -- get the id of the hashtag matching
        SELECT hashtag_id INTO hashtag_id1
        WHERE hashtag_name = tag1;
    ELSE --if hashtag doesn't exist yet, then create a new entry
        INSERT INTO hashtags(hashtag_name)
        VALUES (tag1)
        -- take the last autoincrament id into hashtag_id1;
        SELECT LAST_INSERT_ID() INTO hashtag_id1;
    END IF;

    SELECT COUNT(*) INTO entry_exist
    FROM event_tag WHERE social_event_id = event_id AND hashtag_id = hashtag_id1;

    -- do nothing if the event_tag link table entry already exists, but mostly it doesn't existed yet
    IF entry_exist = 0 THEN
        INSERT INTO event_tag(social_event_id, hashtag_id)
        VALUES (event_id, hashtag_id1)
    END IF;


END //
DELIMITER ;