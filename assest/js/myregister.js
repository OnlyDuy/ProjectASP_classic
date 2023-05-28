function Validator(options) {
    //var formElement = document.querySelector(".form");
    var selectorRules = {};
    // Hàm thực hiện validate
    function validate(inputElement, rule) {
        var spanElement = inputElement.parentElement.querySelector(options.errorSelector);
        var errorMessage;

        // Hiện ra đúng rule khi blur
        var rules = selectorRules[rule.selector];
        for (var i = 0; i < rules.length; i++) {
            errorMessage = rules[i](inputElement.value);
            if (errorMessage) {
                // Nếu lấy ra được 1 rules: thì dừng kiểm tra
                break;
            }
        }

        if (errorMessage) {
            spanElement.innerText = errorMessage;
            inputElement.parentElement.classList.add("invalid");

        }
        else {
            spanElement.innerText = "";
            inputElement.parentElement.classList.remove("invalid");
        }

        return !errorMessage;
    }

    // Lấy ra form element
    var formElement = document.querySelector(options.form);

    if (formElement) {


        // Lặp qua mỗi rule và xử lý (lắng nghe sự kiện blur, input, ...)
        options.rules.forEach(rule => {
            // Lưu lại các rules cho mỗi input, rule.test là function của mỗi selector
            if (Array.isArray(selectorRules[rule.selector])) {
                selectorRules[rule.selector].push(rule.test);
            }
            else {
                selectorRules[rule.selector] = [rule.test];
            }

            var inputElement = document.querySelector(rule.selector);

            if (inputElement) {
                // Xử lý trường hợp blur khỏi input
                inputElement.onblur = () => {
                    validate(inputElement, rule);
                    //console.log(inputElement.value);
                }

                // Xử lý mỗi khi người dùng nhập
                inputElement.oninput = () => {
                    var spanElement = inputElement.parentElement.querySelector(options.errorSelector);
                    spanElement.innerText = "";
                    inputElement.parentElement.classList.remove("invalid");
                }
            }
        });
    }

    //console.log(selectorRules);
}

// Định nghĩa các rules
// TRIM(): loại bỏ dấu cách trước và sau của chuỗi
Validator.isRequired = function (selector) {
    return {
        selector: selector,
        test: function (value) {
            return value.trim() ? "" : "Vui lòng nhập trường này";
        }
    }
}

Validator.isEmail = function (selector) {
    return {
        selector: selector,
        test: function (value) {
            var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            return regex.test(value) ? "" : "Trường này phải là email";
        }
    }
}

Validator.minLength = function (selector, min) {
    return {
        selector: selector,
        test: function (value) {
            return value.length >= min ? "" : `Mật khẩu phải tối thiểu ${min} ký tự`;
        }
    }
}

Validator.isConfirmed = function (selector, getConfirmValue, message) {
    return {
        selector: selector,
        test: function (value) {
            return value === getConfirmValue() ? "" : message || 'Giá trị nhập vào không chính xác';
        }
    }
}