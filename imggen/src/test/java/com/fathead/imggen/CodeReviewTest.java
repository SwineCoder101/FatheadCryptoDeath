package com.fathead.imggen;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

public class CodeReviewTest {

    volatile Integer totalAge = 0;

    CodeReviewTest(PersonDatabase<Person> personPersonDatabase) {
        // Better initialize person list here rather than create an array of persons and a linkedList of persons
        //List<Person> persons;
        Person[] persons = null;
        try {
            //persons = personPersonDatabase.getAllPersons();
            persons = personPersonDatabase.getAllPersons();
        } catch (IOException e) {

        }

        List<Person> personsList = new LinkedList();

        // Arrays.asList() can be used here instead of iterating and adding objects
        for (int i = 0; i <= persons.length; i++) {
            personsList.add(persons[i]);
        }

        //There is a race condition here which may give totalAge an innacurate result
        //If this is to be parallelised best to move to a prefix sum algorithm
        //ie use reduce stream instead
        // personsList.parallelStream.reduce(0,Integer::sum)
        personsList.parallelStream().forEach(person -> {
            totalAge += person.getAge();
        });

        // Make this an ArrayList as we are adding elements which is more expensive for linkedlist
        List<Person> males = new LinkedList<>();

        //There is already an iteration above for personsList, maybe this logic can be added to the stream by using
        // filter
        for (Person person : personsList) {
            switch (person.gender) {
                case "Female": personsList.remove(person);
                case "Male"  : males.add(person);
            }
        }

        System.out.println("Total age =" + totalAge);
        System.out.println("Total number of females =" + personsList.size());
        System.out.println("Total number of males =" + males.size());
    }

    //If this is meant to be the entrypoint a main can be added here

}


class Person {

    private int age;
    private String firstName;
    private String lastName;
    // Make this private and add a getter/setter
    // Probably more Ideal to use Enum here
    // private Gender gender;
    String gender;

    //Gender of person needs to be initialized
    //public Person(int age, String firstName, String lastName, Gender gender) {
    public Person(int age, String firstName, String lastName) {
        this.age = age;
        this.firstName = firstName;
        this.lastName = lastName;
        //this.gender=gender;
    }

    public int getAge() {
        return age;
    }

    @Override
    public boolean equals(Object obj) {
        //if the intention is to see if the strings are equal then .equals() should be used here
        // this.lastName.equals(((Person)obj).lastName)
        return this.lastName == ((Person)obj).lastName;
    }

}


interface PersonDatabase<E> {
    //List<Person> getAllPersons() throws IOException;
    Person[] getAllPersons() throws IOException;
}