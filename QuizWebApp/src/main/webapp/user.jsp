<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Page</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .profile-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }

        .list-group-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
        }


        .footer {
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: #ffffff;
            border-top: 1px solid #dcdcdc;
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 60px;
            box-shadow: 0 -1px 5px rgba(0, 0, 0, 0.1);
        }

        .footer-item {
            text-align: center;
            flex: 1;
        }

        .footer-item i {
            font-size: 24px;
            color: #666;
            display: block;
        }

        .footer-item span {
            display: block;
            margin-top: 5px;
            font-size: 12px;
            color: #666;
        }

        .footer-item:hover span,
        .footer-item:hover i {
            color: blueviolet;
        }

        #footer-user i {
            color: blueviolet;
        }
    </style>
</head>

<body>
<div class="container mt-4 sm-3">

    <div class="d-flex align-items-center mb-4">
        <h2 class="mx-auto" id="welcome-message">Hi <span id="user-name"> loading ...</span> !</h2>
    </div>
    <ul id="user-info" class="list-group">
        <!-- User info will be dynamically inserted here -->
    </ul>
</div>

<div id="guardians-info" class="container mt-4" style="display: none;">
    <!-- Guardians info will be dynamically inserted here -->
</div>

<!-- Modal for editing user profile -->
<div class="modal fade" id="editProfileModal" tabindex="-1" role="dialog" aria-labelledby="editProfileModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editProfileForm">
                    <div class="form-group">
                        <label for="profile-nickname">Nickname</label>
                        <input type="text" class="form-control" id="profile-nickname" name="nickname">
                    </div>
                    <div class="form-group">
                        <label for="profile-email">Email</label>
                        <input type="email" class="form-control" id="profile-email" name="email">
                    </div>
                    <div class="form-group">
                        <label for="profile-phone">Phone</label>
                        <input type="text" class="form-control" id="profile-phone" name="phone">
                    </div>
                    <input type="hidden" id="profile-userId" name="userId">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editBirthModal" tabindex="-1" role="dialog" aria-labelledby="editBirthModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBirthModalLabel">Edit Birth Year</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editBirthForm">
                    <div class="form-group">
                        <label for="birth-input"> Birth Year</label>
                        <input type="text" class="form-control" id="birth-input" name="birth">
                    </div>
                    <input type="hidden" id="birth-userId" name="userId">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>

            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="editEmailModal" tabindex="-1" role="dialog" aria-labelledby="editEmailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editEmailModalLabel">Edit Email</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editEmailForm">
                    <div class="form-group">
                        <label for="email-input">Email</label>
                        <input type="text" class="form-control" id="email-input" name="email">
                    </div>
                    <input type="hidden" id="email-userId" name="userId">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editPhoneModal" tabindex="-1" role="dialog" aria-labelledby="editPhoneModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPhoneModalLabel">Edit Phone</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editPhoneForm">
                    <div class="form-group">
                        <label for="phone-input">Phone</label>
                        <input type="text" class="form-control" id="phone-input" name="phone">
                    </div>
                    <input type="hidden" id="phone-userId" name="userId">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal for editing address -->
<div class="modal fade" id="editAddressModal" tabindex="-1" role="dialog" aria-labelledby="editAddressModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAddressModalLabel">Edit Address</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editAddressForm">
                    <div class="form-group">
                        <label for="address-input">Address</label>
                        <input type="text" class="form-control" id="address-input" name="address">
                    </div>
                    <input type="hidden" id="address-userId" name="userId">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal for editing logout -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">Logout</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to logout?</p>
                <button type="button" class="btn btn-danger" id="confirmLogout">Logout</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for editing password -->
<div class="modal fade" id="editPasswordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel"
     aria-hidden="true">

    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordModalLabel">Edit Password</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editPasswordForm">
                    <div class="form-group">
                        <label for="password-input">Password</label>
                        <input type="password" class="form-control" id="password-input" name="password">
                    </div>
                    <input type="hidden" id="password-userId" name="userId">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </form>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="footer-item" onclick="window.location.replace('/home.jsp')" id="footer-home">
        <i class="fas fa-home"></i>
        <span>Home</span>
    </div>
    <div class="footer-item" onclick="window.location.replace('/quiz_main.jsp')" id="footer-survey">
        <i class="fas fa-compass"></i>
        <span>Survey</span>
    </div>
    <div class="footer-item" id="footer-user">
        <i class="fas fa-user"></i>
        <span>User</span>
    </div>
</footer>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>


    document.addEventListener("DOMContentLoaded", function () {
        axios.post('/user', {
            act: 'getUser',
            user_id: '0'
        })
            .then(response => {
                const user = response.data.users[0];
                const userType = user.user_type;
                const userInfoElement = document.getElementById('user-info');
                const guardiansInfoElement = document.getElementById('guardians-info');
                document.getElementById('user-name').textContent = user.user_name;

                userInfoElement.innerHTML =
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="profile">' +
                    '<span>Profile</span>' +
                    '<img src="https://via.placeholder.com/50" alt="Profile Image" class="profile-img">' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="username">' +
                    '<span>Username</span>' +
                    '<span>' + user.user_name + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="role">' +
                    '<span>Role</span>' +
                    '<span>' + (userType === 2 ? 'Guardian' : 'User') + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="birth_year">' +
                    '<span>Birth Year</span>' +
                    '<span>' + (user.birth_year ? user.birth_year : '<i class="fas fa-qrcode"></i>') + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="email">' +
                    '<span>Email</span>' +
                    '<span>' + (user.email ? user.email : '<i class="fas fa-qrcode"></i>') + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="phone">' +
                    '<span>Phone</span>' +
                    '<span>' + (user.phone ? user.phone : '<i class="fas fa-chevron-right"></i>') + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="address">' +
                    '<span>Address</span>' +
                    '<span>' + (user.address ? user.address : '<i class="fas fa-chevron-right"></i>') + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="password">' +
                    '<span>Password</span>' +
                    '<span>'+ '<i class="fas fa-chevron-right"></i>' + '</span>' +
                    '</li>' +
                    '<li class="list-group-item" data-id="' + user.user_id + '" data-type="logout">' +
                    '<span>Logout</span>' +
                    '<span><i class="fas fa-chevron-right"></i></span>' +
                    '</li>';
            })
            .catch(error => {
                console.error('Error fetching user data:', error);
            });
    });

    document.getElementById('user-info').addEventListener('click', function (event) {
        const target = event.target.closest('li');
        if (target) {
            const userId = target.getAttribute('data-id');
            const type = target.getAttribute('data-type');

            if (type) {
                // Handle modals based on type
                switch (type) {
                    case 'profile':
                        showEditProfileModal(userId);
                        break;
                    case 'email':
                        showEditEmailModal(userId);
                        break;
                    case 'phone':
                        showEditPhoneModal(userId);
                        break;
                    case 'address':
                        showEditAddressModal(userId);
                        break;
                    case 'birth_year':
                        showEditBirthModal(userId);
                        break;
                    case 'password':
                        showEditPasswordModal(userId);
                        break;
                    case 'logout':
                        $('#logoutModal').modal('show');
                        break;
                }
            }
        }
    });


    function showEditPasswordModal(userId) {
        $('#editPasswordModal').modal('show');
    }

    function showEditProfileModal(userId) {
        axios.post('/user', {
            act: 'getUser',
            user_id: userId
        })
            .then(response => {
                const user = response.data;
                document.getElementById('profile-nickname').value = user.nickname || '';
                document.getElementById('profile-email').value = user.email || '';
                document.getElementById('profile-phone').value = user.phone || '';
                document.getElementById('profile-userId').value = user.user_id;
                $('#editProfileModal').modal('show');
            })
            .catch(error => {
                console.error('Error fetching user details for editing profile:', error);
            });
    }


    function showEditBirthModal(userId) {
        axios.post('/user', {
            act: 'getUser',
            user_id: userId
        })
            .then(response => {
                const user = response.data;
                document.getElementById('birth-input').value = user.birth_year || '';
                document.getElementById('birth-userId').value = user.user_id;
                $('#editBirthModal').modal('show');
            })
            .catch(error => {
                console.error('Error fetching user details for editing birth year:', error);
            });
    }


    function showEditEmailModal(userId) {
        axios.post('/user', {
            act: 'getUser',
            user_id: userId
        })
            .then(response => {
                const user = response.data;
                document.getElementById('email-input').value = user.email || '';
                document.getElementById('email-userId').value = user.user_id;
                $('#editEmailModal').modal('show');
            })
            .catch(error => {
                console.error('Error fetching user details for editing email:', error);
            });
    }

    function showEditPhoneModal(userId) {
        axios.post('/user', {
            act: 'getUser',
            user_id: userId
        })
            .then(response => {
                const user = response.data;
                document.getElementById('phone-input').value = user.phone || '';
                document.getElementById('phone-userId').value = user.user_id;
                $('#editPhoneModal').modal('show');
            })
            .catch(error => {
                console.error('Error fetching user details for editing phone:', error);
            });
    }


    function showEditAddressModal(userId) {
        axios.post('/user', {
            act: 'getUser',
            user_id: userId
        })
            .then(response => {
                const user = response.data;
                document.getElementById('address-input').value = user.address || '';
                document.getElementById('address-userId').value = user.user_id;
                $('#editAddressModal').modal('show');
            })
            .catch(error => {
                console.error('Error fetching user details for editing address:', error);
            });
    }

    function deleteAllCookies() {
        const cookies = document.cookie.split("; ");
        for (const cookie of cookies) {
            const [name] = cookie.split("=");
            document.cookie = name+ `=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/;`;
        }
    }


    document.getElementById('editBirthForm').addEventListener('submit', function (event) {
        event.preventDefault();
        axios.post('/user', {
            act: 'setUser',
            users: [
                {
                    password: "SECRET",
                    birth_year: document.getElementById('birth-input').value
                }
            ]
        })
            .then(response => {
                $('#editBirthModal').modal('hide');
                location.reload();
            })
            .catch(error => {
                console.error('Error updating birth year information:', error);
            });
    });


    document.getElementById('editEmailForm').addEventListener('submit', function (event) {
        event.preventDefault();
        axios.post('/user', {
            act: 'setUser',
            users: [
                {
                    password: "SECRET",
                    email: document.getElementById('email-input').value
                }
            ]
        })
            .then(response => {
                $('#editEmailModal').modal('hide');
                location.reload();
            })
            .catch(error => {
                console.error('Error updating email information:', error);
            });
    });

    document.getElementById('editPhoneForm').addEventListener('submit', function (event) {
        event.preventDefault();
        axios.post('/user', {
            act: 'setUser',
            users: [
                {
                    password: "SECRET",
                    phone: document.getElementById('phone-input').value
                }
            ]
        })
            .then(response => {
                $('#editPhoneModal').modal('hide');
                location.reload();
            })
            .catch(error => {
                console.error('Error updating phone information:', error);
            });
    });

    document.getElementById('editAddressForm').addEventListener('submit', function (event) {
        event.preventDefault();
        axios.post('/user', {
            act: 'setUser',
            users: [
                {
                    password: "SECRET",
                    address: document.getElementById('address-input').value
                }
            ]
        })
            .then(response => {
                $('#editAddressModal').modal('hide');
                location.reload();
            })
            .catch(error => {
                console.error('Error updating address information:', error);
            });
    });


    document.getElementById('editPasswordModal').addEventListener('submit', function (event) {
        event.preventDefault();
        axios.post('/user', {
            act: 'setUser',
            users: [
                {
                    password: document.getElementById('password-input').value
                }
            ]
        })
            .then(response => {
                $('#editAddressModal').modal('hide');
                location.reload();
            })
            .catch(error => {
                console.error('Error updating address information:', error);
            });
    });

    document.getElementById('confirmLogout').addEventListener('click', function () {
        deleteAllCookies();
        window.location.href = '/sign-in.jsp'; // Adjust according to your logout endpoint
    });
</script>

</body>
</html>
