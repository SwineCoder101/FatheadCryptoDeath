package com.fathead.imggen;

import lombok.Data;

import java.util.Arrays;

@Data
public class RequestImgMintBody {
    private String[] attributes;
    private String tier;

    @Override
    public String toString(){
        return "Tier: " + tier + ", Attributes: " + Arrays.asList(attributes);
    }
}
