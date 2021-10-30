package com.fathead.imggen;

import org.junit.jupiter.api.Test;

import java.util.Arrays;

public class ParallelStreamTest {
    Integer [] integers = {15,1,23,3,43,553,6,5100,8,5,3,53,225,43,542312,56,5517,5528,3,2,14,5667,8,9,54,26,5,323,643,223,543,2222};
    volatile Integer totalAge=0;
    volatile Integer totalAgeParallel=0;
    volatile Integer totalAgeParallelReduce=0;

    class MockedObj {
        public String getField() {
            return field;
        }

        public void setField(String field) {
            this.field = field;
        }

        public String getFieldTwo() {
            return fieldTwo;
        }

        public void setFieldTwo(String fieldTwo) {
            this.fieldTwo = fieldTwo;
        }

        private String field;
        private String fieldTwo;
        public MockedObj(){
        }
    }

    @Test
    public void testInts(){
        Arrays.asList(integers).stream().forEach(i -> totalAge+=i);
        System.out.println(totalAge);

        Arrays.asList(integers).parallelStream().forEach(i -> totalAgeParallel+=i);
        System.out.println(totalAgeParallel);

        totalAgeParallelReduce=Arrays.asList(integers).parallelStream().reduce(0,Integer::sum);
        System.out.println(totalAgeParallelReduce);
    }

    public void testLists(){
    }


}
