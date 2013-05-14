<?php
require_once('../simpletest/autorun.php');

function anagram_sort($words) {
    $anagrams = array();
    $retval = array();

    foreach($words as $word){
        $word_alphabatized = alphabatize_word($word);
        if(!$anagrams[$word_alphabatized]) $anagrams[$word_alphabatized] = array();
        $anagrams[$word_alphabatized][] = $word;
    }

    foreach($anagrams as $key => $value){
        foreach($value as $word){
            $retval[] = $word;
        }
    }

    return $retval;
}

function alphabatize_word($word){
    $letters = str_split($word);
    sort($letters);
    return implode("", $letters);
}

class AnagramSortTest extends UnitTestCase {

    function testLogCreatesNewFileOnFirstMessage(){
        $this->assertEqual(anagram_sort(array("can", "nac", "asdf", "pappy", "lijen", "acn", "dreams", "nejil")), array("can", "nac", "acn", "asdf", "pappy", "lijen", "nejil", "dreams"));
    }

}

?>