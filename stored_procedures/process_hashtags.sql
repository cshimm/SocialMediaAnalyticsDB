DELIMITER //
CREATE PROCEDURE process_hashtag()
BEGIN

    DECLARE tag_hold VARCHAR(400);
    DECLARE tag1 VARCHAR(45);

    DECLARE data_feed_max INT;
    DECLARE index_val INT DEFAULT 1;


    WHILE index_val < (data_feed_id+1) DO
        -- store hashtags
        SELECT hashtags INTO tag_hold
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

            CALL

            SET idx = idx + 1;
        END WHILE;

    END WHILE;


END //
DELIMITER;




DELIMITER //
CREATE PROCEDURE 