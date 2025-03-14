const toggleButton = document.getElementById('toggle-btn')
const sidebar = document.getElementById('sidebar')

function toggleSidebar() {
	sidebar.classList.toggle('close')
	toggleButton.classList.toggle('rotate')

	closeAllSubMenus()
}

function toggleSubMenu(button) {

	if (!button.nextElementSibling.classList.contains('show')) {
		closeAllSubMenus()
	}

	button.nextElementSibling.classList.toggle('show')
	button.classList.toggle('rotate')

	if (sidebar.classList.contains('close')) {
		sidebar.classList.toggle('close')
		toggleButton.classList.toggle('rotate')
	}
}

function closeAllSubMenus() {
	Array.from(sidebar.getElementsByClassName('show')).forEach(ul => {
		ul.classList.remove('show')
		ul.previousElementSibling.classList.remove('rotate')
	})
}
const menuItems = document.querySelectorAll('#sidebar li')

menuItems.forEach(item => {
	item.addEventListener('click', function() {
		// Xóa class 'active' khỏi tất cả các <li>
		menuItems.forEach(i => i.classList.remove('active'))

		// Thêm class 'active' vào <li> hiện tại
		this.classList.add('active')
	})
})
function loadContent(url, method = 'GET', data = null) {
	const contentArea = document.getElementById('content-area');
	contentArea.classList.add('loading');

	const options = {
		method: method,
		headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: method === 'POST' ? new URLSearchParams(data) : null
	};

	fetch(url, options)
		.then(response => {
			if (!response.ok) throw new Error('Network response was not ok');
			return response.text();
		})
		.then(data => {
			setTimeout(() => {
				contentArea.innerHTML = data;
				contentArea.classList.remove('loading');
				rebindLinks();
			}, 300);
		})
		.catch(error => {
			console.error('Error loading content:', error);
			contentArea.innerHTML = '<p>Có lỗi xảy ra khi tải dữ liệu.</p>';
			contentArea.classList.remove('loading');
		});
}

function rebindLinks() {
	document.querySelectorAll('#content-area a').forEach(link => {
		const href = link.getAttribute('href');
		if (href && href !== '#') {
			link.addEventListener('click', (e) => {
				e.preventDefault();
				if (href.includes('action=delete')) {
					if (confirm('Bạn có chắc muốn xóa?')) {
						fetch(href, { method: 'GET' })
							.then(() => loadContent(href.split('?')[0]));
					}
				} else {
					loadContent(href);
				}
			});
		}
	});

	// Xử lý form submit
	document.querySelectorAll('#content-area form').forEach(form => {
		form.addEventListener('submit', (e) => {
			e.preventDefault();
			const formData = new FormData(form);
			const url = form.getAttribute('action');
			const method = form.getAttribute('method').toUpperCase();

			fetch(url, {
				method: method,
				body: new URLSearchParams(formData)
			})
				.then(response => response.json())
				.then(data => {
					if (data.success) {
						alert(data.message); // Thông báo thành công
						loadContent(data.redirect); // Tải lại danh sách
					} else {
						contentArea.innerHTML = data; // Hiển thị form với lỗi (nếu có)
						contentArea.classList.remove('loading');
						rebindLinks(); // Gắn lại sự kiện
					}
				})
				.catch(error => {
					console.error('Error:', error);
					contentArea.innerHTML = '<p>Có lỗi xảy ra khi gửi dữ liệu.</p>';
					contentArea.classList.remove('loading');
				});
		});
	});
}

