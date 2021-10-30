
//Async to Promise

function loginUser(email,password){
    return new Promise ((accept,reject) => {
        setTimeout(() => {
            accept({userEmail: email});
        },1000);
    } );
}

function getUserVideos(email){
    return new Promise ((accept,reject) => {
    setTimeout(()=> {
        accept (["v1","v2","v3"])
    },1000)
    })
}


// loginUser("email",123456).then(user => getUserVideos(user.email).then( vids => console.log(vids)));

async function displayUser(){
    const loggedUser = await loginUser('ed',12345);
    const userVids = await getUserVideos(loggedUser.userEmail);
    console.log(userVids);
}

displayUser();


// const user=loginUser("email",123456, user => {
//     console.log(user);
//     getUserVideos(user.use, vids => {
//         console.log(vids)
//     })
// });

// const videos=getUserVideos("email", vids => {
//     console.log(vids)
// })


