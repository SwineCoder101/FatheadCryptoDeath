package com.fathead.imggen;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

@RestController
public class Controller {
    private static final String FILEPATH="C:\\dev\\imggen\\src\\main\\resources\\Output.png";

    private String generateImageAndUploadToIPFS(){
        String hash="";
        try {
            ImageGenerator.generateImage(FILEPATH);
            hash = IPFSUpload.uploadToIPFS(FILEPATH);
        } catch (Exception e){
            e.printStackTrace();
        }
        return hash;
    }

    private String getImageURI(){
        return "IMG URI: https://ipfs.io/ipfs/" + generateImageAndUploadToIPFS();
    }

    @GetMapping("/")
    public String index() {
        return getImageURI();
    }

    @ResponseBody
    @PostMapping(path = "/api/generate")
    public MintResponseBody mintImage(@RequestBody RequestImgMintBody requestBody) {
        return new MintResponseBody(true,"Successfully Minted AI Gen Banner",getImageURI());
    }

}
